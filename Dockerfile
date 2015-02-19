###############################################
# Debian with added Teamspeak 3 Server.
# Uses SQLite Database on default.
###############################################

# Using latest debian image as base
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

## Set some variables for override.
# Download Link of TS3 Server
ENV TS3_TGZ teamspeak3-server_linux-amd64-3.0.11.2.tar.gz
ENV TEAMSPEAK_URL http://dl.4players.de/ts/releases/3.0.11.2/${TS3_TGZ}

# path for ts3 directory
WORKDIR /usr/local/src/teamspeak3-server_linux-amd64
ENV TS3_DIR /usr/local/src/teamspeak3-server_linux-amd64/

# Inject a Volume for any TS3-Data that needs to be persisted or to be accessible from the host. (e.g. for Backups)
VOLUME ["/var/lib/backup/teamspeak3","/var/log/ts3"]

# Download TS3 file and extract it into /opt.
ADD ${TEAMSPEAK_URL} /tmp/
RUN cd /usr/local/src/ && tar xvf /tmp/${TS3_TGZ}
COPY ts3server.ini ${TS3_DIR}

#check file
RUN ls -l ${TS3_DIR}
RUN ls -l /tmp/

#Run TS3
#ENTRYPOINT ["ts3server_minimal_runscript.sh"]
CMD ["/usr/local/src/teamspeak3-server_linux-amd64/ts3server_minimal_runscript.sh", "inifile=ts3server.ini"]

# Expose the Standard TS3 port.
EXPOSE 9987/udp
# for files
EXPOSE 30033
# for ServerQuery
EXPOSE 10011
