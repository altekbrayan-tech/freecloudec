FROM node:20-slim

# Instalar dependencias del sistema necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar dependencias de Node
RUN npm ci --only=production || npm install

# Copiar el resto del código del repositorio
COPY . .

# Variables de entorno por defecto
ENV HOST=0.0.0.0
ENV PORT=8082
ENV ALLOW_REMOTE_ADMIN=true
ENV FCC_ALLOW_REMOTE_ADMIN=true

EXPOSE 8082

CMD ["npm", "run", "start"]
