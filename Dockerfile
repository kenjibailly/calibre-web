FROM linuxserver/calibre-web
LABEL maintainer="Kenji Bailly <hello@kenjibailly.xyz>" description="Calibre-Web forked from LinuxServer.io with Calibre and auto-upload for books inspired by MephistoXoL/Docker-CalibreSrv-Web" version="multi.arch"
COPY /app /app/
RUN apt-get update && apt-get install wget -y
RUN apt install libgl1-mesa-glx -y
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin
RUN apt-get install cron -y && apt-get install nano -y
RUN chmod 0744 /app/Auto_Books_Calibre.sh
RUN chown abc /app/Auto_Books_Calibre.sh
#RUN touch /etc/cron.allow
#RUN touch /etc/at.allow
#RUN echo "abc" > /etc/cron.allow
#RUN echo "abc" > /etc/at.allow
#RUN echo "0-59 * * * * abc /app/Auto_Books_Calibre.sh" >> /etc/crontab
#RUN { crontab -l; echo "0-59 * * * * /app/Auto_Books_Calibre.sh"; } | crontab -u abc -
#RUN echo "*/5,*/10,*/15,*/20,*/25,*/30,*/35,*/40,*/45,*/50,*/55,*/59 * * * * abc /app/Auto_Books_Calibre.sh" >> /etc/crontab
#RUN { crontab -l; echo "*/5,*/10,*/15,*/20,*/25,*/30,*/35,*/40,*/45,*/50,*/55,*/59 * * * * /app/Auto_Books_Calibre.sh"; } | crontab -u abc -
RUN mkdir /books
VOLUME /config /books /Books_Calibre /Books_Calibre_Backup /Backup_Library
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 0744 /usr/local/bin/docker-entrypoint.sh
RUN ln -s /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]