FROM yfix/baseimage:16.04

MAINTAINER Yuri Vysotskiy (yfix) <yfix.dev@gmail.com>

RUN cd /tmp \
  && pkg="zabbix-release_3.4-1+xenial_all.deb" \
  && wget -q https://repo.zabbix.com/zabbix/3.4/ubuntu/pool/main/z/zabbix-release/$pkg \
  && dpkg -i $pkg \
  \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    zabbix-server-mysql \
  \
  && apt-get purge -y --auto-remove \
    mysql-client \
    apache2-bin \
    autoconf \
    automake \
    autotools-dev \
    binutils \
    cpp \
    gcc \
  \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && rm -rf /usr/{{lib,share}/share/{man,doc,info,gnome/help,cracklib},{lib,lib64}/gconv} \
  \
  && echo "==== Done ==="

USER zabbix
  
COPY docker /

VOLUME ["/usr/lib/zabbix/alertscripts", "/usr/lib/zabbix/externalscripts", "/etc/zabbix/zabbix_agentd.d"]

EXPOSE 10051 10052

ENTRYPOINT ["/usr/sbin/zabbix_server","-f"]
