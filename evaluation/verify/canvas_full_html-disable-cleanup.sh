#!/usr/bin/env bash
# Execution CLEANUP (canvas_full_html H1): restore shipped default enabled = true. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset canvas_full_html.settings enabled 1 -y >/dev/null 2>&1
echo "cleanup: canvas_full_html.settings:enabled restored to true"
