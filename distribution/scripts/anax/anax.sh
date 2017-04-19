#!/bin/bash -e
#
# anax.sh: a snappy wrapper for the anax horizon system
# author: mdye@us.ibm.com
#

# initial setup of mutable state if this is a first installation
if ! [ -e "$SNAP_COMMON"/workload_ro ]; then
  mkdir -p "$SNAP_COMMON"/workload_ro
fi

if ! [ -e "$SNAP_COMMON"/policy.d ]; then
  mkdir -p "$SNAP_COMMON"/policy.d
fi

# setup agbot specific directories
if ! [ -e "$SNAP_COMMON"/agbot ]; then
  mkdir -p "$SNAP_COMMON"/agbot
fi

if ! [ -e "$SNAP_COMMON"/agbot/policy.d ]; then
  mkdir -p "$SNAP_COMMON"/agbot/policy.d
fi

# always remove the data and copy it again.
# this will make sure the updated snap gets the updated seed data.
rm -Rf $SNAP_DATA/*
cp -Rfap "$SNAP/seed/data/." $SNAP_DATA/

# fake gopath for contracts
C_PATH=$SNAP_DATA/go/src/github.com/open-horizon/go-solidity/
mkdir -p $C_PATH && \
    ln -s $SNAP/contracts $C_PATH/


function sourceOverrideOrDefaultPath() {
  if [ -e "${SNAP_COMMON}/config/$1" ]; then
    echo "${SNAP_COMMON}/config/$1"
  else
    echo "$SNAP_DATA/anax/default-$1"
  fi
}

# for go-solidity contract loading
export GOPATH=$SNAP_DATA/go

# path for state saved by app
export CMTN_WHISPER_ADDRESS_PATH=${CMTN_WHISPER_ADDRESS_PATH:=$SNAP_COMMON/eth/shhid}

# envvars used by go-solidity lib
export mtn_soliditycontract_block_read_delay=${mtn_soliditycontract_block_read_delay:=3}

export CMTN_DIRECTORY_VERSION=${CMTN_DIRECTORY_VERSION:=$(cat $(sourceOverrideOrDefaultPath "horizon_directory_version"))}

export CMTN_EXCHANGE_URL=${CMTN_EXCHANGE_URL:=$(cat $(sourceOverrideOrDefaultPath "horizon_exchange_url"))}

export CMTN_DATA_VERIFICATION_URL=${CMTN_DATA_VERIFICATION_URL:=$(cat $(sourceOverrideOrDefaultPath "horizon_data_verification_url"))}

export CMTN_BLOCKCHAIN=${CMTN_BLOCKCHAIN:=$(cat $(sourceOverrideOrDefaultPath "horizon_blockchain"))}

export CMTN_DEVICE_ID=${CMTN_DEVICE_ID:=$(cat $SNAP_COMMON/config/device_id)}

# anax envvars
ANAX_LOG_LEVEL=${ANAX_LOG_LEVEL:=3}

# write out rendered config file for investigation later
$(dirname $0)/render-config.sh $(sourceOverrideOrDefaultPath "anax.json.tmpl") > ${SNAP_DATA}/anax/rendered-config.json

anax -v=$ANAX_LOG_LEVEL -logtostderr -config $SNAP_DATA/anax/rendered-config.json
