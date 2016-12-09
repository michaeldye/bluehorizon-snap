#!/bin/bash -e
#
# render-config.sh: a script to perform envvar substitutions and set up other
# defaults in the anax config
#
# author: mdye@us.ibm.com
#

if ! [ -n "$HORIZON_WORKLOAD_CPUSET" ]; then
  # N.B.: this is a little naive, it includes HT threads
  NUM=$(nproc)
  if [[ $NUM -gt 2 ]]; then
    export HORIZON_WORKLOAD_CPUSET="1-$((NUM-1))"
  elif [[ $NUM -eq 2 ]]; then
    export HORIZON_WORKLOAD_CPUSET="1"
  else
    export HORIZON_WORKLOAD_CPUSET="0"
  fi
fi

envsubst <$1
