FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copia desde la subcarpeta correspondiente (ajusta 'src' al nombre de tu carpeta)
COPY src/package*.json ./

RUN npm install --omit=dev

COPY src/ ./

ENV HOST=0.0.0.0
ENV PORT=8082
ENV ALLOW_REMOTE_ADMIN=true
ENV FCC_ALLOW_REMOTE_ADMIN=true

EXPOSE 8082

CMD ["npm", "run", "start"]