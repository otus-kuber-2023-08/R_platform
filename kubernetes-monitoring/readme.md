# Description
Вероятно я выбрал easiest way, но чтобы разобраться, пришлось потратить время:-)

Взлетело только после установки label(release: prom-stack) для service monitor. Без этого не взлетело. Похоже проблема была с тем, что matchLabel не подхватывал мои labels, но при их смене для prometheus, результата не было.

# Steps
1. mk start
2. minikube -p minikube docker-env | source 
3. docker build -t nginx-app app/
4. k apply -f nginx-deploy.yml 
5. helm install prom-stack prometheus-community/kube-prometheus-stack
6. helm install nginx-exporter prometheus-community/prometheus-nginx-exporter -f app/values.yaml
7. mk service prom-stack-kube-prometheus-prometheus 
```text
Во вкладке Status/Targets появится serviceMonitor/default/nginx-exporter-prometheus-nginx-exporter/0 для scrape запущенного nginx
```
```text
Можно запустить grafana, для просмотра метрик. Для этого потребуется импортировать готовый dashboard(id=14900).
Запуск Grafana производится командой
mk service prom-stack-grafana
```