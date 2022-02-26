#public gradle image tag supporting multiple platforms
FROM gradle:7.3.3-jdk17

# create system user and group "appuser"
RUN adduser --system --group appuser

USER appuser
COPY --chown=appuser:appuser . /app
WORKDIR /app

ENTRYPOINT [ "./gradlew", "clean", "bootRun" ]
