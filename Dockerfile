FROM yfix/baseimage

MAINTAINER Yuri Vysotskiy (yfix) <yfix.dev@gmail.com>

RUN pkg_name="zabbix-release_3.0-1+trusty_all.deb" \
  && cd /tmp && wget -q http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/$pkg && dpkg -i $pkg && rm -v $pkg \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    zabbix-server-mysql \
  && echo "==== Done ==="

VOLUME ["/usr/lib/zabbix/alertscripts", "/usr/lib/zabbix/externalscripts", "/etc/zabbix/zabbix_agentd.d"]

EXPOSE 10051 10052

ENTRYPOINT ["/bin/docker-zabbix"]
CMD ["run"]
