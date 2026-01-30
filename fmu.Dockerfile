FROM px4io/px4-dev-nuttx-focal:2022-08-12

RUN pip install fastcrc

WORKDIR px4
