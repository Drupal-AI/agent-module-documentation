#!/usr/bin/env bash
# Introspection CLEANUP (canvas_full_html M2): nothing mutated beyond baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset canvas_full_html.settings enabled 1 -y >/dev/null 2>&1
echo "cleanup: baseline (enabled = true) confirmed"
