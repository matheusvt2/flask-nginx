# Criação de um container Nginx com app em SSL

Referência: [Nginx com SSL auto assinado](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04)
Referência 2: [Streamlit Nginx](https://github.com/Taxuspt/heroku_streamlit_nginx)

## Squencia de comandos

```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./certs/nginx-selfsigned.key -out ./certs/nginx-selfsigned.crt
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```

uwsgi --pp app/ --socket 0.0.0.0:5000 --protocol=http -w wsgi:app
streamlit hello--server.enableCORS false --server.port 5000

### utils

/app/scripts/entrypoint.sh streamlit

ps -A | grep nginx | awk '{print $1}' | xargs kill -9 $1
cp /workspaces/nginx/nginx/nginx.conf /etc/nginx/nginx.conf
nginx && streamlit hello --server.enableCORS false --server.port 5000

nginx &&  uwsgi --pp app/ --socket 0.0.0.0:5000 --protocol=http -w wsgi:app
## Terminar