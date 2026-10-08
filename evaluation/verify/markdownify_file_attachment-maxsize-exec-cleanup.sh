#!/usr/bin/env bash
# Execution CLEANUP: restore default max_file_embed_size (1 MB). Idempotent.
set -uo pipefail
cd /var/www/html
drush cset markdownify_file_attachment.settings max_file_embed_size "1 MB" -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: max_file_embed_size=1 MB (default restored)"
