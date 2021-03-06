# Unbound-DNS Monitoring
Template Unbound DNS - Zabbix 

## You need to install [zabbix_sender](https://www.zabbix.com/download) on unbound
[Zabbix Sender Documentation](https://www.zabbix.com/documentation/3.4/manual/concepts/sender)

## In the configuration file of unbound.conf it is necessary to activate the following options
![](https://i.ibb.co/nmYF7KW/statics.png)

[Unbound Documentation - Howto Statistics](https://nlnetlabs.nl/documentation/unbound/howto-statistics/)

# Usage on crontab example:
*/5   **** root sh /home/dir/unboundSend.sh 192.168.10.1 Unbound > /dev/null


## Graphs numbers of answers: 
![](https://i.ibb.co/vj70h0T/Answer.png)

## Graphs informations requests:
![](https://i.ibb.co/BCgHrVW/Informations.png)

## Graphs number queries type:
![](https://i.ibb.co/zZTLsD4/Query-Type.png)

## Graphs total queries, cache/miss/recursive/prefetch
![](https://i.ibb.co/XkhX6jx/Total-Queries.png)
