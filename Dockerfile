FROM ich777/debian-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-steamcmd-server"

RUN apt-get update && \
	apt-get -y install --no-install-recommends \
	lib32gcc-s1 lib32stdc++6 xdg-user-dirs \
	build-essential cmake check libbsd-dev \
	libglib2.0-dev bc git && \
	rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/n0la/rcon.git && \
	cd rcon && \
	mkdir build && \
	cd build && \
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr && \
	make && \
	make install

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="2394010"
ENV GAME_PARAMS=""
ENV GAME_PARAMS_EXTRA="-useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
ENV UPDATE_PUBLIC_IP="false"
ENV BACKUP="false"
ENV BACKUP_INTERVAL=120
ENV BACKUPS_TO_KEEP=12
ENV VALIDATE=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""
ENV ADMIN_PASSWORD="adminDocker"
ENV USER="steam"
ENV DATA_PERM=770
ENV MEMORY_THRESHOLD=80
ENV KILL_TIMER=600

RUN mkdir $DATA_DIR && \
	mkdir $STEAMCMD_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

COPY scripts /opt/scripts/
RUN chmod -R 770 /opt/scripts/

CMD ls -la /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
