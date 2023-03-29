# Traefik dev

Traefik container for development.

## Run on your machine

```bash
docker network create proxy
./setup-certs.sh
```

This will install certificates and run the traefik container in restart always mode.

You can acces the traefik dashboard at [https://traefik.njk.localhost/dashboard/].

## Create new projects
This traefik setup is used to deploy various https urls for multiple local projects.
It requires a little docker-compose configuration:

In services that requires to be accessible (like UIs & databases), add the `labels` and `network` keys.

```yaml
services:
  my-service:
    build: .
    container_name: project.njk.localhost
    security_opt:
      - no-new-privileges:true
      ...
      
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.cavity.rule=Host(\`project.njk.localhost\`)"
      - "traefik.http.routers.cavity.tls=true"
      - "traefik.docker.network=proxy"
    networks:
      - default
      - proxy

```

Your service will be accessible at `project.njk.localhost`

## Uninstall
A side effect is that you can no longer access your `localhost` using unsecure http from now on.
If you need to access `localhost` without https, run the following commands:

```bash
cd traefik
docker compose down
./mkcert -uninstall
```

Restart your machine and follow this link: http://localhost?a=1 .

You should be able to access `localhost` using unsecure http now.
