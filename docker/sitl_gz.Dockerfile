FROM px4io/px4-dev-simulation-jammy:latest

RUN apt-get update && \
    apt-get install -y clangd clang && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install mavp2p
RUN ARCH=$(dpkg --print-architecture) && \
    MAVP2P_VERSION=$(curl -s https://api.github.com/repos/bluenviron/mavp2p/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/') && \
    wget -q https://github.com/bluenviron/mavp2p/releases/latest/download/mavp2p_${MAVP2P_VERSION}_linux_${ARCH}.tar.gz && \
    tar -xzf mavp2p_${MAVP2P_VERSION}_linux_${ARCH}.tar.gz && \
    mv mavp2p /usr/local/bin/ && \
    rm mavp2p_${MAVP2P_VERSION}_linux_${ARCH}.tar.gz

COPY gcs_mavlink_router.sh /gcs_mavlink_router.sh
RUN chmod +x /gcs_mavlink_router.sh
# RUN echo '/gcs_mavlink_router.sh' >> /etc/bash.bashrc

WORKDIR px4-docker/px4

RUN git config --global --add safe.directory '*'
