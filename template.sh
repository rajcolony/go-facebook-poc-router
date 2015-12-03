#!/bin/bash
cat > router.json <<EOF
{
  "id": "/edgerouter",
  "cpus": 1,
  "mem": 256,
  "instances": 1,
  "constraints": [["hostname", "UNIQUE"]],
  "acceptedResourceRoles": ["slave_public"],
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "$APP_IMAGE",
      "network": "BRIDGE",
      "forcePullImage": true,
      "portMappings": [
          {
              "containerPort": 8080,
              "hostPort": 80,
              "protocol": "tcp"
          }
      ]
    }
  },
  "healthChecks": [{
      "protocol": "TCP",
      "gracePeriodSeconds": 600,
      "intervalSeconds": 30,
      "portIndex": 0,
      "timeoutSeconds": 10,
      "maxConsecutiveFailures": 2
  }],
  "env": {"APP_NAME": "$APP_NAME"}
}
EOF
