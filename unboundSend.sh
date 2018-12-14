#!/bin/bash
#	@Jefte de Lima Ferreira
#	jeftedelima at gmail dot com
#	CRON Example
#	*/5   **** root sh /home/dir/unboundSend.sh 192.168.10.1 Unbound 1> /dev/null	

if [ -z ${1} ] || [ -z ${2} ] ; then
	echo "You need to specify the IP address of zabbix server and hostname of your DNS Unbound on zabbix"
	echo "Usage example: ./unboundSend.sh 192.168.10.1 UnboundServer"
	exit 1
fi

# ZABBIX_SERVER IP
IP_ZABBIX=$1
# NAME Unbound on Zabbix
NAME_HOST=$2
DIR_TEMP=/var/tmp/
FILE="${DIR_TEMP}dump_unbound_control_stats.txt"
unbound-control stats > ${FILE}

TOTAL_NUM_QUERIES=$(cat ${FILE} | grep -w 'total.num.queries' | cut -d '=' -f2)
TOTAL_NUM_CACHEHITS=$(cat ${FILE} | grep -w 'total.num.cachehits' | cut -d '=' -f2)
TOTAL_NUM_CACHEMISS=$(cat ${FILE} | grep -w 'total.num.cachemiss' | cut -d '=' -f2)
TOTAL_NUM_PREFETCH=$(cat ${FILE} | grep -w 'total.num.prefetch' | cut -d '=' -f2)
TOTAL_NUM_RECURSIVEREPLIES=$(cat ${FILE} | grep -w 'total.num.recursivereplies' | cut -d '=' -f2)

TOTAL_REQ_MAX=$(cat ${FILE} | grep -w 'total.requestlist.max' | cut -d '=' -f2)
TOTAL_REQ_AVG=$(cat ${FILE} | grep -w 'total.requestlist.avg' | cut -d '=' -f2)
TOTAL_REQ_OVERWRITTEN=$(cat ${FILE} | grep -w 'total.requestlist.overwritten' | cut -d '=' -f2)
TOTAL_REQ_EXCEEDED=$(cat ${FILE} | grep -w 'total.requestlist.exceeded' | cut -d '=' -f2)
TOTAL_REQ_CURRENT_ALL=$(cat ${FILE} | grep -w 'total.requestlist.current.all' | cut -d '=' -f2)
TOTAL_REQ_CURRENT_USER=$(cat ${FILE} | grep -w 'total.requestlist.current.user' | cut -d '=' -f2)

TOTAL_TCPUSAGE=$(cat ${FILE} | grep -w 'total.tcpusage' | cut -d '=' -f2)

NUM_QUERY_TYPE_A=$(cat ${FILE} | grep -w 'num.query.type.A' | cut -d '=' -f2)
NUM_QUERY_TYPE_NS=$(cat ${FILE} | grep -w 'num.query.type.NS' | cut -d '=' -f2)
NUM_QUERY_TYPE_MX=$(cat ${FILE} | grep -w 'num.query.type.MX' | cut -d '=' -f2)
NUM_QUERY_TYPE_TXT=$(cat ${FILE} | grep -w 'num.query.type.TXT' | cut -d '=' -f2)
NUM_QUERY_TYPE_PTR=$(cat ${FILE} | grep -w 'num.query.type.PTR' | cut -d '=' -f2)
NUM_QUERY_TYPE_AAAA=$(cat ${FILE} | grep -w 'num.query.type.AAAA' | cut -d '=' -f2)
NUM_QUERY_TYPE_SRV=$(cat ${FILE} | grep -w 'num.query.type.SRV' | cut -d '=' -f2)
NUM_QUERY_TYPE_SOA=$(cat ${FILE} | grep -w 'num.query.type.SOA' | cut -d '=' -f2)

NUM_ANSWER_RCODE_NOERROR=$(cat ${FILE} | grep -w 'num.answer.rcode.NOERROR' | cut -d '=' -f2)
NUM_ANSWER_RCODE_NXDOMAIN=$(cat ${FILE} | grep -w 'num.answer.rcode.NXDOMAIN' | cut -d '=' -f2)
NUM_ANSWER_RCODE_SERVFAIL=$(cat ${FILE} | grep -w 'num.answer.rcode.SERVFAIL' | cut -d '=' -f2)
NUM_ANSWER_RCODE_REFUSED=$(cat ${FILE} | grep -w 'num.answer.rcode.REFUSED' | cut -d '=' -f2)
NUM_ANSWER_RCODE_nodata=$(cat ${FILE} | grep -w 'num.answer.rcode.nodata' | cut -d '=' -f2)
NUM_ANSWER_secure=$(cat ${FILE} | grep -w 'num.answer.secure' | cut -d '=' -f2)

#	Sending info to zabbix_server, if variables is not empty!
[ -z ${TOTAL_NUM_QUERIES} ] ||  zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.num.queries -o ${TOTAL_NUM_QUERIES}
[ -z ${TOTAL_NUM_CACHEHITS} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.num.cachehits -o ${TOTAL_NUM_CACHEHITS}
[ -z ${TOTAL_NUM_CACHEMISS} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.num.cachemiss -o ${TOTAL_NUM_CACHEMISS}
[ -z ${TOTAL_NUM_PREFETCH} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.num.prefetch -o ${TOTAL_NUM_PREFETCH}
[ -z ${TOTAL_NUM_RECURSIVEREPLIES} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.num.recursivereplies -o ${TOTAL_NUM_RECURSIVEREPLIES}

[ -z ${TOTAL_REQ_MAX} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.requestlist.max -o ${TOTAL_REQ_MAX}
[ -z ${TOTAL_REQ_AVG} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.requestlist.avg -o ${TOTAL_REQ_AVG}
[ -z ${TOTAL_REQ_OVERWRITTEN} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.requestlist.overwritten -o ${TOTAL_REQ_OVERWRITTEN}
[ -z ${TOTAL_REQ_EXCEEDED} ] ||  zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.requestlist.exceeded -o ${TOTAL_REQ_EXCEEDED}
[ -z ${TOTAL_REQ_CURRENT_ALL} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.requestlist.current.all -o ${TOTAL_REQ_CURRENT_ALL}
[ -z ${TOTAL_REQ_CURRENT_USER} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.requestlist.current.user -o ${TOTAL_REQ_CURRENT_USER}

[ -z ${TOTAL_TCPUSAGE} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k total.tcpusage -o ${TOTAL_TCPUSAGE}

[ -z ${NUM_QUERY_TYPE_A} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.query.a -o ${NUM_QUERY_TYPE_A}
[ -z ${NUM_QUERY_TYPE_NS} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.query.ns -o ${NUM_QUERY_TYPE_NS}
[ -z ${NUM_QUERY_TYPE_MX} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.query.mx -o ${NUM_QUERY_TYPE_MX}
[ -z ${NUM_QUERY_TYPE_TXT} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.query.txt -o ${NUM_QUERY_TYPE_TXT}
[ -z ${NUM_QUERY_TYPE_PTR} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.query.ptr -o ${NUM_QUERY_TYPE_PTR}
[ -z ${NUM_QUERY_TYPE_AAAA} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.query.aaaa -o ${NUM_QUERY_TYPE_AAAA}
[ -z ${NUM_QUERY_TYPE_SRV} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.query.srv -o ${NUM_QUERY_TYPE_SRV}
[ -z ${NUM_QUERY_TYPE_SOA} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.query.soa -o ${NUM_QUERY_TYPE_SOA}

[ -z ${NUM_ANSWER_RCODE_NOERROR} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.answer.rcode.NOERROR -o ${NUM_ANSWER_RCODE_NOERROR}
[ -z ${NUM_ANSWER_RCODE_NXDOMAIN} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.answer.rcode.NXDOMAIN -o ${NUM_ANSWER_RCODE_NXDOMAIN}
[ -z ${NUM_ANSWER_RCODE_SERVFAIL} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.answer.rcode.SERVFAIL -o ${NUM_ANSWER_RCODE_SERVFAIL}
[ -z ${NUM_ANSWER_RCODE_REFUSED} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.answer.rcode.REFUSED -o ${NUM_ANSWER_RCODE_REFUSED}
[ -z ${NUM_ANSWER_RCODE_nodata} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.answer.rcode.nodata -o ${NUM_ANSWER_RCODE_nodata}
[ -z ${NUM_ANSWER_secure} ] || zabbix_sender -z ${IP_ZABBIX} -s ${NAME_HOST} -k num.answer.secure -o ${NUM_ANSWER_secure}
