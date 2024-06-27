#!/bin/bash

# Nome do serviço no docker-compose
SERVICE_NAME=scraping_sydle_onu

# Diretório do projeto
PROJECT_DIR="/etc/fbx/node-php"

# Arquivo de log
LOG_FILE="/etc/fbx/sydle_log.log"

# Função para registrar com timestamp
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}
# Limpa o log
> $LOG_FILE

# Entrar no diretório do projeto
cd $PROJECT_DIR

# Registrar início da execução
log "Iniciando execução do script"

# Derrubar o contêiner específico
log "Parando e removendo contêiner antigo"
docker-compose stop $SERVICE_NAME >> $LOG_FILE 2>&1
docker-compose rm -f $SERVICE_NAME >> $LOG_FILE 2>&1

# Construir e iniciar o contêiner específico
log "Construindo e iniciando novo contêiner"
docker-compose up --build -d $SERVICE_NAME >> $LOG_FILE 2>&1

# Aguardar a execução do script (ajuste conforme necessário)
log "Aguardando execução do script no contêiner"
sleep 30

# Derrubar o contêiner específico
log "Parando e removendo contêiner após execução"
docker-compose stop $SERVICE_NAME >> $LOG_FILE 2>&1
docker-compose rm -f $SERVICE_NAME >> $LOG_FILE 2>&1

# Registrar fim da execução
log "Execução do script finalizada"
