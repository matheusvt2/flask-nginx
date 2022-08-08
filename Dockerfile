FROM amazonlinux:latest
# Copy files to container
ADD . /app

# Set the workdir
WORKDIR /app

# Install OS requirements
RUN yum update -y && yum upgrade -y  && yum install $(cat os-requirements.txt) -y && yum clean all

# Install amazon nginx
RUN amazon-linux-extras install nginx1 -y

# Install /app requirements
RUN  python3 -m pip install -r requirements.txt

# Uncomment this if you already have generated your certificate.
# ADD ./certs/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key  
# ADD ./certs/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
# ADD ./certs/dhparam.pem /etc/ssl/certs/dhparam.pem

# Generate a self-signed certificate on docker build. Comment this if uncomment above lines.
# Change  the value of SUBJ 
ARG SUBJ="/C=BR/ST=SP/L=SaoPaulo/O=My app LTDA/OU=IT/CN=localhost"
RUN chmod +x /app/scripts/createcert.sh
RUN /app/scripts/createcert.sh "$SUBJ"

# Configure nginx
# Change nginx/nginx.conf accordingly with your projetc
RUN mkdir -p /etc/nginx/snippets
RUN cp -r conf/nginx/snippets /etc/nginx/
RUN cp conf/nginx/nginx.conf /etc/nginx/nginx.conf

# Entrypoint file. Comment this lines if you don't want to start nginx.
RUN chmod +x /app/scripts/entrypoint.sh
ENTRYPOINT  ["/app/scripts/entrypoint.sh"]
