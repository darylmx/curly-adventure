# An alpine image is generally smaller in size 
# and results in increaed deployment speeds and reduced costs.
# The attack surface is also smaller and is thus preferred for security reasons.
FROM gradle:7.3.3-jdk17-alpine

# A non-root user is created and used during runtime for security reasons.
RUN adduser -D appuser

USER appuser
COPY --chown=appuser:appuser . /app
WORKDIR /app

ENTRYPOINT [ "./gradlew", "clean", "bootRun" ]
