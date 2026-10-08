#!/usr/bin/env bash
# Execution RESET (canvas_full_html H1): restore shipped default enabled = true, so the
# empty/baseline state makes the "disable it" verify FAIL. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset canvas_full_html.settings enabled 1 -y >/dev/null 2>&1
echo "reset: canvas_full_html.settings:enabled = true (baseline)"
