#!/usr/bin/env bash
# Introspection CLEANUP: remove the template created by the matching setup. Idempotent. Exit 0.
set -uo pipefail
rm -rf /var/www/html/web/sites/default/files/tx_med1
echo "cleanup: removed tx_med1 template dir"
