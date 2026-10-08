#!/usr/bin/env bash
# Execution CLEANUP (insert_view_adv_bueditor): remove the answer artifact. Idempotent. Exit 0.
set -uo pipefail
rm -f /tmp/iva_bueditor_integration.txt
echo "cleanup: removed /tmp/iva_bueditor_integration.txt"
