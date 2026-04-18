
#!/usr/bin/bash
AUDIT_PATH="$PATH"
LOG="$HOME/logs/path_audit.log"
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

mkdir -p "$HOME/logs"
echo "================================"
echo "PATH Security Audit Report"
echo "started:  $TIMESTAMP"
echo "================================"
echo ""
echo "Current PATH:"
echo "$AUDIT_PATH" | tr ':' '\n'
echo ""


echo "--- Directory Analysis ---"
echo ""
echo "$AUDIT_PATH" | tr ':' '\n' | while read dir; do
	
    if [ "$dir" = "." ]; then
        echo "[CRITICAL] Current directory in PATH"
    elif [ "$dir" = "" ]; then
        echo "[CRITICAL] Empty entry in PATH"
    elif [ ! -d "$dir" ]; then
        echo "[WARN] $dir does not exist"
    else
        OWNER=$(ls -ld "$dir" | awk '{print $3}')
        if [ "$OWNER" != "root" ]; then
            echo "[CRITICAL] $dir owned by $OWNER not root"
        else
            echo "[OK] $dir owned by root"
        fi
    fi
done

echo ""
echo "================================"
echo "Audit complete.  logs saved to : $LOG"
echo "================================"




=================================================================
#!usr/bin/bash

# function no.1 
collect_path_issues()
{
AUDIT_PATH="$PATH"
issues=()

while IFS=  read -r  dir; do

if [ "$dir" = "." ]; then
issues+=("CRITICAL: current directory in path")

elif [ -z "$dir" ]; then
issues+=("CRITICAL: empty PATH entry")

elif [ ! -d "$dir" ]; then
issues+=("WARN: $dir  does not exist.")

else 

OWNER=$(stat -c  %U  "$dir"  2>/dev/null)
        if [ "!OWNER"  != "root" ];then
        issues+=("CRITICAL: $dir owned by $OWNER")
        fi
fi

done <<<  "$(echo "AUDIT_PATH" |tir  ':'  '\n')"

}

# function no.2

log_path_issues()
{
LOG="$HOME/logs/path_audit.log"
mkdir -p "$HOME/logs"
}

# function no. 3
output_path_json()
{

}

# function no. 4

output_path_cli()
{
echo "PATH AUDIT RESULT"
for i in  "${issues[@]}"; do
        echo "$1"
        done
}


# function no. 5

if [ "$1" = = "--json" ];then
output_path_json
else
output_path_cli
log_path_issues

fi







