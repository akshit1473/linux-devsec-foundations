#!usr/bin/bash

echo " =================================================="
echo  "                    PROCESS MONITOR               "
echo " ================================================="

echo ""
echo "[TOP CPU PROCESSES] "
echo '-----------------------'

printf "%-15s"
get_top_cpu_json()
{
ps -eo pid,comm,state,%cpu,%mem --sort=-%cpu |  awk '
NR > 1 && $2 != "ps"{

}


#sort through the processes with the highest cpu usage and  show the top 5.

echo ""
echo "[TOP MEMORY PROCESSES]"
echo '-------------------------'
ps -eo pid,comm,state,%cpu,%mem  --sort=-%mem |grep -v ps |  head -n 6


echo ""
echo "[PROCESS STATES]: "
echo '-----------------------'
ps -eo pid,comm,state,%cpu,%mem --sort=-%cpu | grep -v ps |  head -n 11

echo ""
echo "[ZOMBIES PROCESS]"
echo "-----------------------"

zombies=$(ps -eo pid,comm,state | awk '$3 ~/z/')

if [ -z "$zombies" ];then
echo "none detected"
else 
echo "$zombies"
fi

# -eo allows user to basically cherry pick what  fields they want to see

echo "========================================="
echo  "      PROCESS MONITOR COMPLETE          "
echo "========================================="

