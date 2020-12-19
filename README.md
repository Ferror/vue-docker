# vue docker image

## Example
```
services:
    traefik:
        image: "traefik:2.3"
        container_name: "traefik"
        command:
            - "--log.level=DEBUG"
            - "--api.insecure=true"
            - "--providers.docker=true"
            - "--providers.docker.exposedbydefault=false"
            - "--entrypoints.web.address=:80"
        ports:
            - "80:80"
            - "8080:8080"
        volumes:
            - /var/run/docker.sock:/var/run/docker.sock:ro
        networks:
            ferror:
                ipv4_address: 192.168.10.2

    vue:
        container_name: "vue"
        build:
            context: ./
        command: ["make", "run"]
        labels:
            - "traefik.enable=true"
            - "traefik.http.routers.vue.rule=Host(`vue.malcherczyk.localhost`)"
        volumes:
            - ./:/app:delegated
        networks:
            - ferror

networks:
    ferror:
        name: ferror
        driver: bridge
        ipam:
            driver: default
            config:
                - subnet: 192.168.10.0/24

```
