# px4-docker

## Prerequisites
- PX4 resides in `../px4/`, otherwise change the path/dirname in `./docker/docker_compose.yml`
- Docker Engine, Docker Compose

## Usage (with the Newton simulator)

```
cd docker
docker compose up px4-sitl-newton
docker exec -it px4-sitl-newton bash
make px4_sitl newton_astro
```

Then open `http://127.0.0.1:9090` in your browser to see the visualization.

Note: to run on a remote server, connect with port forwarding (required for Rerun web viewer) using `ssh -L 9090:localhost:9090 -L 9876:localhost:9876 <user>@<remote-ip>`, and open `http://127.0.0.1:9090/?url=rerun%2Bhttp%3A%2F%2F127.0.0.1%3A9876%2Fproxy` in your browser. If you want to connect to a GCS running locally, you will need a MAVLink router (such as mavp2p) installed in order to create a TCP server on (for example) port 5760 such that the GCS can connect through the SSH tunnel. The command for mavp2p (run this on the server) is `mavp2p udps:0.0.0.0:14550 tcps:0.0.0.0:5760`. To forward TCP port 5760, specify it in the ssh command: `ssh -L 5760:localhost:5760 <user>@<remote-ip>`. Then create the comm link (TCP, 127.0.0.1:5760) in the GCS and connect.

## Usage (with the Gazebo simulator)

```
cd docker
docker compose up px4-sitl-gz -d
docker exec -it px4-sitl-gz bash
HEADLESS=1 make px4_sitl gz_x500
```

To fix X11 auth mounting (required for GUI support only) issues:
```
sudo rm -rf /tmp/.docker.xauth
touch /tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -
```
