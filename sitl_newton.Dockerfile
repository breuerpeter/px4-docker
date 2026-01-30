  FROM nvidia/cuda:13.0.1-devel-ubuntu22.04

  # Prevent interactive prompts
  ENV DEBIAN_FRONTEND=noninteractive

  # PX4 SITL minimal dependencies (no Gazebo)
  RUN apt-get update && apt-get install -y \
      git \
      make \
      cmake \
      ninja-build \
      g++ \
      gcc-arm-none-eabi \
      python3-pip \
      python3.11 \
      python3.11-venv \
      python3.11-dev \
      software-properties-common \
      && rm -rf /var/lib/apt/lists/*

# uv for Python package management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv
ENV UV_PYTHON=python3.11

RUN pip3 install --no-cache-dir \
	'empy>=3.3,<4' \
	'jinja2>=2.8' \
	jsonschema \
	kconfiglib \
	packaging \
	pyros-genmsg \
	pyyaml

WORKDIR px4

RUN git config --global --add safe.directory '*'
