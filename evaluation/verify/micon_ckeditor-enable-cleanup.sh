#!/usr/bin/env bash
# Execution CLEANUP: ensure micon_ckeditor is enabled (the assignment baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install micon_ckeditor -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: micon_ckeditor enabled (baseline)"
