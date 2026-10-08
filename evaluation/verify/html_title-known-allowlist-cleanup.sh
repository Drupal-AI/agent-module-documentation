#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default allowlist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set html_title.settings allow_html_tags '<br> <sub> <sup>' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: html_title.settings allow_html_tags restored to '<br> <sub> <sup>'"
