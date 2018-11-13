ARG CUDA_VERSION=9.2
ARG BUILD_FLAVOR=devel
ARG RUN_FLAVOR=base
ARG DISTRO=ubuntu18.04

FROM nvidia/cuda:${CUDA_VERSION}-${BUILD_FLAVOR}-${DISTRO} AS build

ENV XMR_STAK_VERSION '2.5.2'
ENV CMAKE_OPTS '-DMICROHTTPD_ENABLE=OFF -DXMR-STAK_COMPILE=generic -DHWLOC_ENABLE=OFF -DCPU_ENABLE=OFF -DOpenCL_ENABLE=OFF'

RUN apt-get update \
    && apt-get -y install --no-install-recommends cmake g++ gcc git libc++-dev libssl-dev make \
    && git clone https://github.com/fireice-uk/xmr-stak.git \
    && cd xmr-stak \
    && git checkout ${XMR_STAK_VERSION} \
    && mkdir build \
    && cd build \
    && cmake .. ${CMAKE_OPTS} \
    && make install


FROM nvidia/cuda:${CUDA_VERSION}-${RUN_FLAVOR}-${DISTRO}

LABEL maintainer='docker@merxnet.io'

COPY --from=build /xmr-stak/build/bin/* /usr/local/bin/

RUN apt-get update \
    && apt-get -y install --no-install-recommends gcc libc++1

WORKDIR /usr/local/bin

ENTRYPOINT ["xmr-stak"]
