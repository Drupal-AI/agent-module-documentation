#!/usr/bin/env bash
# Execution RESET: force html_title allowlist to '<br>' only (no <em>), so verify FAILS until
# the agent adds italics support. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set html_title.settings allow_html_tags '<br>' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: html_title.settings allow_html_tags = '<br>' (no <em>)"
