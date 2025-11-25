FROM px4io/px4-dev-nuttx-focal:2022-08-12

RUN pip install fastcrc

RUN apt-get update && \
    apt-get install -y clangd clang && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

