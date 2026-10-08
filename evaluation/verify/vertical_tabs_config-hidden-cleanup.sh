#!/usr/bin/env bash
# Introspection CLEANUP: remove the article/author visibility row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sqlq "DELETE FROM vertical_tabs_config WHERE content_type='article' AND vertical_tab='author';" >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: article/author visibility row removed"
