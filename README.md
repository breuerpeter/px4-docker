# px4-docker

The fastest way to get starting with building PX4 NuttX and SITL targets.

## Prerequisites
- PX4 repo cloned
- Docker Engine and Docker Compose installed

## One-time setup

```
cd <PX4 root dir>
git clone git@github.com:breuerpeter/px4-docker.git docker
cd docker
chmod +x *.sh
```

Optional, but recommended:
- Add to git exclude file: `./setup_gitexclude.sh`
- Install bash shell helpers for running PX4: `./setup_px4_helper.sh && source ~/.bashrc`. This provides the following bash commands:
    - `cdpx` to navigate to the PX4 root dir (configured by `PX4_DIR` in `px4_helpers.sh`).
    - `mpx` to build/run PX4 targets (NuttX and SITL). Check usage with `mpx --help`.
    - `mavtcp` to start a MAVLink router that allows you to connect your GCS running locally to a PX4 instance running on a remote server that you connect to via SSH. Requires `mavp2p` on the remote server.

## Usage

| Target             | Using helpers | Manual |
|--------------------|---------------|--------|
| **NuttX example**  | `mpx fmu v3` | `docker compose up px4-nuttx -d && docker exec -it px4-fmu make px4_fmu-v3` |
| **SITL example**   | `mpx newton quad_x` | `docker compose up px4-sitl-newton -d && docker exec -it px4-sitl-newton make px4_sitl newton_quad_x` |


If running SITL with the Newton simulator, open [this address](http://127.0.0.1:9090/?url=rerun%2Bhttp%3A%2F%2F127.0.0.1%3A9876%2Fproxy) in your browser to see the visualization. If you are working on a remote server, connect using SSH with port forwarding (required for the Rerun web viewer) using `ssh -L 9090:localhost:9090 -L 9876:localhost:9876 <user>@<remote-ip>`. If you want to connect to a GCS running locally, you will need a MAVLink router (such as mavp2p) installed in order to create a TCP server on (for example) port 5760 such that the GCS can connect through the SSH tunnel. If you have `mavp2p` installed on the remote server, just run `mavtcp`. To forward TCP port 5760, specify it in the ssh command: `ssh -L 5760:localhost:5760 <user>@<remote-ip>`. Then create the comm link (TCP, 127.0.0.1:5760) in the GCS and connect.

To fix X11 auth mounting (required for GUI support - e.g., when using Gazebo - only) issues:
```
sudo rm -rf /tmp/.docker.xauth
touch /tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -
```
