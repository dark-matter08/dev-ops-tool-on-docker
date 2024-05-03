#!/bin/bash
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 \
    -subj "/CN=registry" \
    -keyout domain.key -out domain.crt \
    -addext "subjectAltName = IP:190.92.151.125,DNS:registry"