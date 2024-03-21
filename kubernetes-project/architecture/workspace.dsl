workspace {
    !docs docs

    model {
        user = person "User"
        microservices = softwareSystem "Microservices demo" {
          adService = container "AdService" "" "" "Backend"
          cartService = container "Cart Service" "" "" "Backend"
          checkoutService = container "Checkout Service" "" "" "Backend"
          currencyService = container "Currency Service" "" "" "Backend"
          emailService = container "Email Service" "" "" "Backend"
          frontedService = container "Frontend" "" "" "Frontend"
          paymentService = container "Payment Service" "" "" "Backend"
          productCatalogService = container "Product Catalog Service" "" "" "Backend"
          recommendationService = container "Recommendation Service" "" "" "Backend"
          redisService = container "Redis Service" "" "" "Backend"
          shippingService = container "Shipping Service" "" "" "Backend"
        }
        user -> microservices
        
        live = deploymentEnvironment "Live" {
          kubernetesCluster = deploymentNode "Kubernetes cluster" {
            masterNode = deploymentNode "master" {
              instances 3
              tags "Kubernetes - master"
              kubernetesApi = infrastructureNode "kubernetes API" {
                tags "Kubernetes - api"
              }
              etcdNode = infrastructureNode "ETCD" {
                tags "Kubernetes - etcd"
              }
              kubernetesSchedulerNode = infrastructureNode "Kubernetes Scheduler" {
                tags "Kubernetes - sched"
              }
              controllerManagerNode = infrastructureNode "Controller Manager" {
                tags "Kubernetes - cm"
              }


            }
            workerNode = deploymentNode "worker" {
              instances 2
              tags "Kubernetes - node"
              applicationNode = deploymentNode "Application" {
                adServiceInstance = containerInstance "adService" "" "Kubernetes - deploy"
                cartServiceInstance = containerInstance "cartService" "" "Kubernetes - deploy"
                checkoutServiceInstance = containerInstance "checkoutService" "" "Kubernetes - deploy"
                currencyServiceInstance = containerInstance "currencyService" "" "Kubernetes - deploy"
                emailServiceInstance = containerInstance "emailService" "" "Kubernetes - deploy"
                frontedServiceInstance = containerInstance "frontedService" "" "Kubernetes - deploy"
                paymentServiceInstance = containerInstance "paymentService" "" "Kubernetes - deploy"
                productCatalogServiceInstance = containerInstance "productCatalogService" "" "Kubernetes - deploy"
                recommendationServiceInstance = containerInstance "recommendationService" "" "Kubernetes - deploy"
                redisServiceInstance = containerInstance "redisService" "" "Kubernetes - deploy"
                shippingServiceInstance = containerInstance "shippingService" "" "Kubernetes - deploy"
                tags "Kubernetes - ns"
              }


              deploymentNode "ArgoCD" {
               argoCdNode = infrastructureNode "ArgoCD-Server" {
                  tags "ArgoCD"
               }
               tags "Kubernetes - ns"
              }
              deploymentNode "Consul" {
                consulServerNode = infrastructureNode "Consul-server" {
                  tags "Consul"
                }
               tags "Kubernetes - ns"
              }
              deploymentNode "observability" {
               tags "Kubernetes - ns"
                kibanaNode = infrastructureNode "Kibana" {
                  tags "Kibana"
                }
                elasticsearchNode = infrastructureNode "Elasticsearch" {
                  tags "Elasticsearch"
                }
                fluentDNode = infrastructureNode "FluentD" {
                  tags "FluentD"
                }
                jaegerNode = infrastructureNode "Jaeger" {
                  tags "Jaeger"
                }
                prometheusNode = infrastructureNode "Prometheus" {
                  tags "Prometheus"
                }
                grafanaNode = infrastructureNode "Grafana" {
                  tags "Grafana"
                }
              }
              kubeletNode = infrastructureNode "Kubelet" {
                tags "Kubernetes - kubelet"
              }
              kubeProxy = infrastructureNode "Kube Proxy" {
                tags "Kubernetes - k-proxy"
              }
              deploymentNode "Infra" {
                vaultServerNode = infrastructureNode "Vault server" {
                  tags "Vault"
                }
               tags "Kubernetes - ns"
              }
            }
            ingress = deploymentNode "ingress" {
              instances 2
              tags "Kubernetes - ing"
              ingressControllerNode = infrastructureNode "Ingress controller" {
                tags "Kubernetes - ing"
              }
            }
          }
          yandexCloudInfrastructure = deploymentNode "Yandex Cloud Infrastructure" {
              yandexCloudObjectStorageNode = infrastructureNode "Yandex Cloud Object Storage" {
                 description "S3"
                 technology "S3"
                 tags "Kubernetes - pv,S3"
              }
              loadBalancerInfra = infrastructureNode "Yandex Load Balancer" {
                 tags "Kubernetes - svc"
                 url "https://cloud.yandex.ru/ru/docs/network-load-balancer/quickstart?from=int-console-help-center-or-nav"
               }
          }



           loadBalancerInfra -> ingress
           ingress -> workerNode
           workerNode -> yandexCloudObjectStorageNode
           prometheusNode -> yandexCloudObjectStorageNode
           grafanaNode -> prometheusNode
        }
    }

    views {
      deployment * Live {
        include *
      }
      styles {
        element "Element" {
          shape RoundedBox
        }
        element "Balancer" {
          icon "load-balancer-icon-26797.png"
        }
        element "ArgoCD" {
          icon "argocd.png"
        }
        element "Grafana" {
          icon "Grafana.png"

        }
        element "S3" {
          shape "Folder"
        }
        element "Prometheus" {
          icon "prometheus.png"

        }
        element "Kibana" {
          icon "kibana.png"

        }
        element "Elasticsearch" {
          icon "elasticsearch.png"

        }
        element "FluentD" {
          icon "fluentd.png"

        }
        element "Jaeger" {
          icon "jaeger.png"

        }
        element "Vault" {
          icon "vault.png"

        }
        element "Consul" {
          icon "consul.png"

        }
        element "Backend" {
            shape "Hexagon"
        }
        element "Frontend" {
          shape "WebBrowser"
        }
      }
        themes "https://static.structurizr.com/themes/kubernetes-v0.3/theme.json"
    }

}