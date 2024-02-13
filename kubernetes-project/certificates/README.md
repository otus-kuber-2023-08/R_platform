To generate a certificate with subject alternative names (SANs), you can use OpenSSL. OpenSSL is a widely-used open-source library for SSL/TLS and certificate management.

Here are the steps to generate a certificate with subject alternative names using OpenSSL:

1. Create a configuration file:
   Create a text file with a .cnf extension (e.g., san.cnf). This file will contain the configuration for the certificate generation. Here's an example configuration:
```text
   [req]
   distinguished_name = req_distinguished_name
   req_extensions = v3_req
   prompt = no

   [req_distinguished_name]
   C = CountryCode
   ST = State
   L = Locality
   O = Organization
   CN = CommonName

   [v3_req]
   subjectAltName = @alt_names

   [alt_names]
   DNS.1 = example.com
   DNS.2 = www.example.com
   IP.1 = 192.168.0.1
   IP.2 = 10.0.0.1
```


Customize the distinguished_name section with your desired country, state, locality, organization, and common name.

In the [alt_names] section, add all the DNS names and IP addresses you want to include as SANs. The format for DNS names is DNS.<number> and for IP addresses is IP.<number>.

2. Generate a private key:
   Run the following OpenSSL command to generate a private key:
```shell
   openssl genpkey -algorithm RSA -out private.key
```


This will generate a private key file called private.key.

3. Generate a certificate signing request (CSR):
   Run the following OpenSSL command to generate a CSR using the private key and the configuration file:
```shell
   openssl req -new -key private.key -out csr.csr -config san.cnf
```

Replace san.cnf with the path to your configuration file, if it is located in a different directory.

This will generate a CSR file called csr.csr.

4. Generate the certificate:
   To generate a self-signed certificate using the CSR and private key, run the following OpenSSL command:
```shell
   openssl x509 -req -in csr.csr -signkey private.key -out certificate.crt -extensions v3_req -extfile san.cnf -days 365
```

Replace san.cnf with the path to your configuration file, if it is located in a different directory.

This will generate a self-signed certificate called certificate.crt valid for 365 days.

You now have a certificate with subject alternative names (SANs) that you can use in your applications or web servers. Make sure to replace the placeholder values in the configuration file with your actual values.