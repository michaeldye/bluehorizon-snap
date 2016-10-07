#!/bin/bash -e
#
# anax-wrapper.bash: a snappy wrapper for the anax horizon-os daemon
# author: mdye@us.ibm.com
#

# initial setup of mutable state if this is a first installation
if ! [ -e "$SNAP_COMMON"/workload_ro ]; then
  mkdir -p "$SNAP_COMMON"/workload_ro
fi

if ! [ "$(ls -A $SNAP_DATA/)" ]; then
  cp -Rfap "$SNAP/seed/data/." $SNAP_DATA/

  # fake gopath for contracts
  C_PATH=$SNAP_DATA/go/src/repo.hovitos.engineering/MTN/go-solidity/
  mkdir -p $C_PATH && \
    ln -s $SNAP/contracts $C_PATH/
fi

# for chain selection convenience
if [ -e "/boot/firmware/horizon_directory_version" ]; then
  cp /boot/firmware/horizon_directory_version $SNAP_DATA/anax/directory_version
fi

export CMTN_DIRECTORY_VERSION=${CMTN_DIRECTORY_VERSION:=$(cat $SNAP_DATA/anax/directory_version)}

export CMTN_WHISPER_ADDRESS_PATH=${CMTN_WHISPER_ADDRESS_PATH:=$SNAP_COMMON/eth/shhid}

# for go-solidity contract loading
export GOPATH=$SNAP_DATA/go

ANAX_LOG_LEVEL=${ANAX_LOG_LEVEL:=3}

# for help debugging startup
env

anax -v=$ANAX_LOG_LEVEL -alsologtostderr -config <(cat $SNAP_DATA/anax/config.tmpl | envsubst)
