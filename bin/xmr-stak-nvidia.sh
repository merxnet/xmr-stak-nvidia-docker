#!/usr/bin/env bash

ulimit -l 262144

POOL=
WALLET=
PASSWD=
CURR=monero7

if [[ -f /etc/xmr-stak/config.txt && -f /etc/xmr-stak/pools.txt && -f /etc/xmr-stak/nvidia.txt ]]; then
  nvidia-docker run -d --rm --name xmr-stak-nvidia -v /etc/xmr-stak:/etc/xmr-stak:ro merxnet/xmr-stak-nvidia \
    -c /etc/xmr-stak/config.txt \
    -C /etc/xmr-stak/pools.txt \
    --nvidia /etc/xmr-stak/nvidia.txt
else
  nvidia-docker run -d --rm --name xmr-stak-nvidia merxnet/xmr-stak-nvidia \
    -o ${POOL}
    -u ${WALLET} \
    -p ${PASSWD} \
    --currency ${CURR}
fi
