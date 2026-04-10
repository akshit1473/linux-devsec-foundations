#!/bin/bash
# path_auditor.sh
# audits PATH directories for common security risks
# concepts used: PATH structure, environment variables, security hardening

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin


echo "================================"
echo "PATH Security Audit Report"
echo "================================"
echo ""
echo "Current PATH:"
echo "$PATH" | tr ':' '\n'
echo ""
echo "--- Directory Analysis ---"
echo ""

echo "$PATH" | tr ':' '\n' | while read dir; do

    if [ "$dir" = "." ]; then
        echo "[CRITICAL] '.' (current directory) is in PATH — hijacking risk"

    elif [ -z "$dir" ]; then
        echo "[WARN] Empty entry found in PATH"

    elif [ ! -d "$dir" ]; then
        echo "[WARN] $dir — does not exist"

    else
        OWNER=$(ls -ld "$dir" | awk '{print $3}')

        if [ "$OWNER" != "root" ]; then
            echo "[CRITICAL] $dir — owned by '$OWNER', not root"
        else
            echo "[OK] $dir — owned by root"
        fi
    fi

done

echo ""
echo "================================"
echo "Audit complete."
echo "================================"
