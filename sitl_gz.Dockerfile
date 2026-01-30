FROM px4io/px4-dev-simulation-jammy:latest

WORKDIR px4-docker/px4

RUN git config --global --add safe.directory '*'
