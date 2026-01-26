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

# TODO: copied from Tools/setup/requirements.txt. Remove unnecessary ones
RUN pip3 install --no-cache-dir \
	argcomplete \
	cerberus \
	coverage \
	'empy>=3.3,<4' \
	future \
	'jinja2>=2.8' \
	jsonschema \
	kconfiglib \
	lxml \
	'matplotlib>=3.0' \
	'numpy>=1.13' \
	'nunavut>=1.1.0' \
	packaging \
	'pandas>=0.21' \
	pkgconfig \
	psutil \
	pygments \
	'wheel>=0.31.1' \
	pymavlink \
	pyros-genmsg \
	pyserial \
	'pyulog>=0.5.0' \
	pyyaml \
	requests \
	'setuptools>=39.2.0' \
	'six>=1.12.0' \
	'toml>=0.9' \
	'sympy>=1.10.1'

RUN git config --global --add safe.directory '*'
