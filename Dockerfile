FROM eclipse-temurin:17-jre

# Instalar Node.js
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash", "-c", "while true; do sleep 3600; done"]