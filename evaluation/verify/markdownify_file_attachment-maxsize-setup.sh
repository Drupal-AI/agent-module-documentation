#!/usr/bin/env bash
# Introspection SETUP: set max_file_embed_size to a distinctive 512 KB. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset markdownify_file_attachment.settings max_file_embed_size "512 KB" -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: max_file_embed_size=512 KB"
