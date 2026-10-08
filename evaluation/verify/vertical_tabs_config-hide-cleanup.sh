#!/usr/bin/env bash
# Execution CLEANUP: remove the article/options hide row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sqlq "DELETE FROM vertical_tabs_config WHERE content_type='article' AND vertical_tab='options';" >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: article/options hide row removed"
