#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default mobile breakpoint (640). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset ebt_core.settings ebt_core_mobile_breakpoint '640' -y >/dev/null 2>&1
echo "cleanup: ebt_core_mobile_breakpoint restored to 640"
