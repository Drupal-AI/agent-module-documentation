#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default EBT background color (#0d77b5). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset ebt_core.settings ebt_core_background_color '#0d77b5' -y >/dev/null 2>&1
echo "cleanup: ebt_core_background_color restored to #0d77b5"
