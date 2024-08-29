# Use a imagem base do Ubuntu
FROM ubuntu:latest

# Instala pacotes necessários
RUN apt-get update && apt-get install -y \
    build-essential \
    mpich \
    python3 \
    python3-pip \
    python3-mpi4py \
    openssh-server

# Configura o diretório de trabalho
WORKDIR /app

# Gera chaves SSH e configura
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -N ""
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# Copia o script MPI para o container
COPY shared/mpi.py app/shared/mpi.py

# Configura o SSH para aceitar conexões
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# Exposição da porta SSH
EXPOSE 22

# Inicia o SSH e mantém o container ativo
CMD ["/usr/sbin/sshd", "-D"]
#CMD service ssh start && mpiexec -n 4 python3 /app/mpi.py
