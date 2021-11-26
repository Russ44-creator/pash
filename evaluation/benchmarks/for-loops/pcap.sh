#!/bin/bash
#tag: pcap analysis
IN=${IN:-$PASH_TOP/evaluation/benchmarks/for-loops/input/pcap_data}
OUT=${OUT:-$PASH_TOP/evaluation/benchmarks/for-loops/input/output/pcap-analysis}
LOGS=${OUT}/logs
mkdir -p ${LOGS}
run_tests() {
    INPUT=$1
    /usr/sbin/tcpdump -nn -r ${INPUT} -A 'port 53'| sort | uniq |grep -Ev '(com|net|org|gov|mil|arpa)'
    # extract URL
    /usr/sbin/tcpdump -nn -r ${INPUT} -s 0 -v -n -l | egrep -i "POST /|GET /|Host:"
    # extract passwords
    /usr/sbin/tcpdump -nn -r ${INPUT} -s 0 -A -n -l | egrep -i "POST /|pwd=|passwd=|password=|Host:"
}
export -f run_tests

pkg_count=0

for item in ${IN}/*;
do
    pkg_count=$((pkg_count + 1));
    run_tests $item > ${LOGS}/${pkg_count}.log
done



echo 'done';
