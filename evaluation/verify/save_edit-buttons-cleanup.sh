#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults.
set -uo pipefail
cd /var/www/html
drush cset save_edit.settings button_value 'Save & Edit' -y >/dev/null 2>&1
drush cset save_edit.settings hide_default_save 0 -y >/dev/null 2>&1
echo "cleanup: button_value='Save & Edit', hide_default_save=0"
