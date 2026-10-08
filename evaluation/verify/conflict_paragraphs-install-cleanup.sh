#!/usr/bin/env bash
# Execution CLEANUP: ensure conflict_paragraphs is enabled again (documented baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install conflict_paragraphs -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: conflict_paragraphs enabled (baseline restored)"
