# Dockerized XMR-Stak (NVIDIA GPU) Monero miner

[![GitHub Release](https://img.shields.io/github/release/merxnet/xmr-stak-nvidia-docker/all.svg)](https://github.com/merxnet/xmr-stak-nvidia-docker/releases)
[![GitHub Release Date](https://img.shields.io/github/release-date-pre/merxnet/xmr-stak-nvidia-docker.svg)](https://github.com/merxnet/xmr-stak-nvidia-docker/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/merxnet/xmr-stak-nvidia.svg)](https://hub.docker.com/r/merxnet/xmr-stak-nvidia/)

The goal for this code is to create a modular and easy-to-use Docker image of the popular XMR-Stak (NVIDIA GPU) Monero miner. Discover and support the source code [here](https://github.com/fireice-uk/xmr-stak). There are also code repositories for "Dockerized" versions of the [CPU](https://github.com/merxnet/xmr-stak-cpu-docker) and [AMD GPU](https://github.com/merxnet/xmr-stak-amd-docker) miners as well. Note that XMR-Stak offers a unified miner which supports CPUs and AMD/NVIDIA GPUs; however, for simplicity each image contains source code compiled for a single purpose.

## Quickstart
The Docker image created by this code is conveniently available on [Docker Hub](https://hub.docker.com/r/merxnet/xmr-stak-nvidia/).
```
docker pull merxnet/xmr-stak-nvidia
```
To get started, install the NVIDIA drivers, CUDA toolkit, NVIDIA runtime for Docker on your host machine (see the [Host Configuration](#host-configuration) section below). Once complete, all you need is a [wallet](https://getmonero.org/resources/user-guides/create_wallet.html) and a [mining pool](https://monero.org/services/mining-pools/) of your choice, such as [MoriaXMR](https://moriaxmr.com/). You may also be prompted for a password, which in this case is simply an identifer for the host. This information can be provided on the command line at run time:
```
nvidia-docker run merxnet/xmr-stak-nvidia -o ${POOL} -u ${WALLET} -p ${PASSWD} --currency monero
```
To get the most out of mining, be sure to check out the sections below as well as the documentation at the [source code's GitHub page](https://github.com/fireice-uk/xmr-stak/blob/master/doc/usage.md).

## Usage
This Docker image can be treated just like the binary -- that is, you can provide any and all command line options directly. For example:
```
nvidia-docker run -d --name xmr-stak-nvidia merxnet/xmr-stak-nvidia \
  -O us.moriaxmr.com:9000 \
  -u ${WALLET} \
  -p ${PASSWD} \
  --currency monero
```
Most often it is easiest to provide configuration files. To do this, it is recommended that all configuration files be stored in the same directory on the host and then passed to the container at runtime:
```
nvidia-docker run -d -v /etc/xmr-stak:/etc/xmr-stak:ro merxnet/xmr-stak-nvidia \
  -c /etc/xmr-stak/config.txt \
  -C /etc/xmr-stak/pools.txt \
  --nvidia /etc/xmr-stak/nvidia.txt
```
To see examples and benchmarks, visit the [XMR-Stak website](https://www.xmrstak.com/).

## Host Configuration
For NVIDIA GPU mining, the host machine (i.e., the machine running `dockerd`) **MUST** have the NVIDIA drivers and CUDA toolkit installed. Most Linux distributions will have NVIDIA drivers available in their corresponding package repositories; otherwise, refer to the [NVIDIA Download Drivers](http://www.nvidia.com/Download/index.aspx) site.

To find out how to install the CUDA toolkit on various Linux distributions, take a look at the [Dockerfiles created by NVIDIA](https://hub.docker.com/r/nvidia/cuda/) for that purpose. Take the commands found there and run them on the host machine; otherwise, refer to the [NVIDIA CUDA Toolkit](https://developer.nvidia.com/cuda-toolkit) site.

Lastly, as mentioned above, the host machine must also have the [NVIDIA runtime for Docker](https://github.com/NVIDIA/nvidia-docker#quickstart) installed.

## Support
Feel free to fork and create pull requests or create issues. Feedback is always welcomed. One can also send donatations to the Monero wallet below.
```
43txUsLN5h3LUKpQFGsFsnRLCpCW7BvT2ZKacsfuqYpUAvt6Po8HseJPwY9ubwXVjySe5SmxVstLfcV8hM8tHg8UTVB14Tk
```
Thank you.
