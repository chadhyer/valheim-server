FROM cm2network/steamcmd

WORKDIR /home/steam/steamcmd
USER steam

RUN /home/steam/steamcmd/steamcmd.sh +force_install_dir ./valheim +login anonymous +app_update 896660 +quit

COPY --chown=steam:steam ./entry.sh /home/steam/steamcmd/entry.sh

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/home/steam/steamcmd/entry.sh" ]