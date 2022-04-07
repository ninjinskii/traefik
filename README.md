# Traefik dev

Traefik container for development

## Run on your machine

```bash
docker network create proxy
./setup-certs.sh
```

This will install certificates and run the traefik container in restart always mode
