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
NR > 1 && $2 != "ps" {
        printf "{\"pid\": %s, \"cmd\": \"%s\", \"state\": \"%s\", \"cpu\": %s, \"mem\": %s},\n",
        $1, $2, $3, $4, $5
    }
    ' | head -n 5
}

#sort through the processes with the highest cpu usage and  show the top 5.

echo ""
echo "[TOP MEMORY PROCESSES]"
echo '-------------------------'
get_top_mem_json()
{
ps -eo pid,comm,state,%cpu,%mem  --sort=-%mem | awk '
NR > 1 && $2 != "ps" {
        printf "{\"pid\": %s, \"cmd\": \"%s\", \"state\": \"%s\", \"cpu\": %s, \"mem\": %s},\n",
        $1, $2, $3, $4, $5
    }
    ' | head -n 5
}


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

main_json()
{
echo "{"
echo "\"top_cpu\": ["
get_top_cpu_json
echo "],"

echo "\"top_mem\": ["
get_top_mem_json
echo "],"
echo "{"
}

main_cli(){
echo "[TOP CPU PROCESSES]"
echo "[TOP MEMORY PROCESSES]"
}

if [ "$1" =="--json"];then
main_json
else
main_cli
if





# -eo allows user to basically cherry pick what  fields they want to see

echo "========================================="
echo  "      PROCESS MONITOR COMPLETE          "
echo "========================================="

