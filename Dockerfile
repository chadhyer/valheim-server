FROM cm2network/steamcmd

WORKDIR /home/steam/steamcmd
USER steam

RUN apt-get update -y && apt-get install -y \
        curl \
        libatomic1 \
        libpulse-dev \
        libpulse0 \
        && rm -rf /var/lib/apt/lists/*
RUN /home/steam/steamcmd/steamcmd.sh +force_install_dir ./valheim +login anonymous +app_update 896660 +quit

COPY --chown=steam:steam ./entry.sh /home/steam/steamcmd/entry.sh

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/home/steam/steamcmd/entry.sh" ]