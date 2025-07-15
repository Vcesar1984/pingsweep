#!/bin/bash

#########################################################
#                Para utilizar o script                 #
# chmod +x pingsweep.sh                                 #
# ./pingsweep.sh ALVO                                   #
# ./pingsweep.sh 192.168.1                              #
#########################################################


# Função para interromper o envio de pacote (CTRL+C)
interromper() {
    echo -e "\nScan interrompido pelo usuário."
    exit 0
}

# Captura o comando de interrupção SIGINT (CTRL+C)
trap interromper SIGINT

# Verifica se o usuário forneceu um intervalo de IP
if [ -z "$1" ]; then
    echo "Uso: $0 <prefixo_da_rede>"
    echo "Exemplo: $0 192.168.1"
    exit 1
fi

# Define o prefixo da rede
prefixo=$1

# Define o intervalo de IPs (1 a 254)
for i in {1..254}; do
    # Faz o ping no endereço IP
    ping -c 1 -W 1 "${prefixo}.${i}" > /dev/null

    # Verifica se o host respondeu
    if [ $? -eq 0 ]; then
        echo "Host ${prefixo}.${i} está ativo!"
    else
        echo "Host ${prefixo}.${i} não está respondendo."
    fi
done
