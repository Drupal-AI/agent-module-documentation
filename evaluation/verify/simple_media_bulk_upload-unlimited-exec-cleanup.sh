#!/usr/bin/env bash
# Execution CLEANUP: restore default max_files=30. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset simple_media_bulk_upload.settings max_files 30 -y >/dev/null 2>&1
echo "cleanup: simple_media_bulk_upload.settings max_files=30 (default)"
