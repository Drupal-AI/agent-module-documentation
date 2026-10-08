#!/usr/bin/env bash
# Introspection CLEANUP (check_dns): baseline is check_dns enabled; nothing to undo. Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: check_dns left enabled (baseline)"
