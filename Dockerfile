FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiamos todo el contexto del repositorio primero
COPY . .

# Imprimimos la estructura para ver exactamente dónde está package.json en los logs de Dokploy
RUN echo "=== Directorio raíz (/app) ===" && ls -la /app

# Si package.json está en la raíz, npm install funcionará. 
# Si está dentro de una subcarpeta, ajústalo según lo que imprima el 'ls -la' superior.
RUN npm install --omit=dev

ENV HOST=0.0.0.0
ENV PORT=8082
ENV ALLOW_REMOTE_ADMIN=true
ENV FCC_ALLOW_REMOTE_ADMIN=true

EXPOSE 8082

CMD ["npm", "run", "start"]