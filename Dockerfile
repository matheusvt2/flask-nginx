FROM amazonlinux:latest

ADD . /app

WORKDIR /app

RUN yum update -y && yum upgrade -y  && yum install python3 python3-devel nginx python3-pip  \
wget  gcc make -y && yum clean all

# RUN  ./site/sqlite/configure && ./site/sqlite/make
RUN  python3 -m pip install -r requirements.txt

RUN amazon-linux-extras install nginx1 -y

ADD ./certs/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key  
ADD ./certs/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
ADD ./certs/dhparam.pem /etc/ssl/certs/dhparam.pem

RUN mkdir -p /etc/nginx/snippets

RUN cp -r ./snippets /etc/nginx/
RUN cp nginx/nginx.conf  /etc/nginx/nginx.conf

ENTRYPOINT  ["nohup", "/usr/sbin/nginx", "-g", "daemon off;"]
CMD ["uwsgi", "--pp", "app/"," --socket", "0.0.0.0:5000". "--protocol=http", "-w", "wsgi:app"]

