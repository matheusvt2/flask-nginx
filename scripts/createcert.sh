#!/bin/bash
check_code()
{
    if [ "$1" -ne 0 ]
    then
        echo "An error ocurred! Files not generated."
        exit 1
    else
        echo "Files generated successfully"
    fi
}

mkdir -p /etc/ssl/private

echo "Wait... creating keys."

openssl req \
-x509 \
-newkey rsa:2048 \
-nodes \
-days 365 \
-subj "$1" \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out /etc/ssl/certs/nginx-selfsigned.crt  &>/dev/null

check_code $?

echo "Wait... creating dhparam."
openssl dhparam \
-out /etc/ssl/certs/dhparam.pem 2048 &>/dev/null

check_code $?
