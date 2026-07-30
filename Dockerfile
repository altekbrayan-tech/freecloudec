FROM node:20-slim

# Instalar dependencias necesarias del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Establecer directorio de trabajo
WORKDIR /app

# Copiar todo el código fuente al contenedor
COPY . .

# Instalar dependencias directamente desde package.json
RUN npm install --omit=dev

# Variables de entorno
ENV HOST=0.0.0.0
ENV PORT=8082
ENV ALLOW_REMOTE_ADMIN=true
ENV FCC_ALLOW_REMOTE_ADMIN=true

EXPOSE 8082

CMD ["npm", "run", "start"]