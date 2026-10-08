#!/usr/bin/env bash
# Execution RESET: ensure the 'options' (Promotion options) tab is NOT hidden on Article by removing
# any matching row from the vertical_tabs_config table, so verify FAILS until the agent hides it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sqlq "DELETE FROM vertical_tabs_config WHERE content_type='article' AND vertical_tab='options';" >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no hide row for article/options"
