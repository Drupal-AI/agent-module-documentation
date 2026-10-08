#!/usr/bin/env bash
# Execution CLEANUP: ensure groupmedia_paragraphs is enabled (documented baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush en groupmedia_paragraphs -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: groupmedia_paragraphs enabled"
