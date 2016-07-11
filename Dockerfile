FROM ubuntu:16.04

MAINTAINER antespi@gmail.com

ENV HOST='localhost' \
    ROOT_EMAIL_FROM='postmaster' \
    ROOT_EMAIL_TO='cron' \
    MAIL_RELAY_HOST='smtp_relay' \
    MAIL_RELAY_PORT='25' \
    MAIL_RELAY_USER='' \
    MAIL_RELAY_PASS=''

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y rsyslog ssmtp cron && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/cache/apt/archives/* /var/cache/apt/*.bin /var/lib/apt/lists/*

ADD entrypoint /usr/local/bin/
RUN chmod a+rx /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["tail", "-f", "/var/log/syslog"]
VOLUME ["/var/log"]
