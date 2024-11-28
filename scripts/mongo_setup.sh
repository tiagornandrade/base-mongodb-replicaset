#!/bin/bash

sleep 15

mongosh --host base-mongodb-replicaset-mongo1-1:27017 <<EOF
  var cfg = {
    "_id": "myReplicaSet",
    "version": 1,
    "members": [
      {
        "_id": 0,
        "host": "base-mongodb-replicaset-mongo1-1:27017",
        "priority": 2
      },
      {
        "_id": 1,
        "host": "base-mongodb-replicaset-mongo2-1:27018",
        "priority": 0
      },
      {
        "_id": 2,
        "host": "base-mongodb-replicaset-mongo3-1:27019",
        "priority": 0
      }
    ]
  };
  rs.initiate(cfg);
EOF
