# px4-docker

## Prerequisites
- PX4 resides in `../px4/`
- Docker Engine, Docker Compose

## Usage

```
cd docker
docker compose up px4-dev-sitl -d
docker exec -it px4-dev-sitl bash
HEADLESS=1 make px4_sitl gz_x500
```
