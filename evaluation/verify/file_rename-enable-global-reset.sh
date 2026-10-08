#!/usr/bin/env bash
# Execution RESET: force file_rename global flag always_show_widget_link OFF (0) so verify FAILS
# until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set file_rename.settings always_show_widget_link 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: file_rename.settings:always_show_widget_link = 0"
