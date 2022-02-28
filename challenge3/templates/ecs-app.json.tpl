[
  {
    "name": "${APP_NAME}",
    "image": "${REPOSITORY_URL}:${TAG}",
    "cpu": ${CONTAINER_CPU},
    "memory": ${CONTAINER_MEMORY},
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${APP_PORT},
        "hostPort": ${APP_PORT}
      }
    ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${LOG_GROUP}",
          "awslogs-region": "${LOG_REGION}",
          "awslogs-stream-prefix": "ecs"
      }
    }
  }
]