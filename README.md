# Criação de um container Nginx com app em SSL

Referência: [how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04)

## Squencia de comandos

```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./certs/nginx-selfsigned.key -out ./certs/nginx-selfsigned.crt
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```
uwsgi --pp app/ --socket 0.0.0.0:5000 --protocol=http -w wsgi:app

## Terminar