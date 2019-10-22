#!/usr/bin/env bash

# Disable virtual nodes
sed -i -e "s/num_tokens/\#num_tokens/" $SCYLLA_CONFIG/scylla.yaml

# With virtual nodes disabled, we have to configure initial_token
sed -i -e "s/\# initial_token:/initial_token: 0/" $SCYLLA_CONFIG/scylla.yaml
# echo "JVM_OPTS=\"\$JVM_OPTS -Dcassandra.initial_token=0\"" >> $CASSANDRA_CONFIG/cassandra-env.sh

# set 0.0.0.0 Listens on all configured interfaces
sed -i -e "s/^rpc_address.*/rpc_address: 0.0.0.0/" $SCYLLA_CONFIG/scylla.yaml

# Be your own seed
# sed -i -e "s/- seeds: \"127.0.0.1\"/- seeds: \"$SEEDS\"/" $CASSANDRA_CONFIG/scylla.yaml

# # Disable gossip, no need in one node cluster
echo "skip_wait_for_gossip_to_settle: 0" >> $SCYLLA_CONFIG/scylla.yaml

exec "$@"

