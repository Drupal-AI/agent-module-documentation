#!/usr/bin/env bash
# Execution RESET: force max_file_embed_size to 1 MB so verify FAILS until agent raises it to
# 2 MB. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset markdownify_file_attachment.settings max_file_embed_size "1 MB" -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: max_file_embed_size=1 MB"
