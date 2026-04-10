#!/usr/bin/bash
AUDIT_PATH="$PATH"
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin                                              
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
echo "Audit complete."
echo "================================"


