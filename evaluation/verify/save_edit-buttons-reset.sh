#!/usr/bin/env bash
# Execution RESET: restore button_value and hide_default_save to shipped defaults so the
# "relabel + hide default Save" task genuinely fails until performed. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset save_edit.settings button_value 'Save & Edit' -y >/dev/null 2>&1
drush cset save_edit.settings hide_default_save 0 -y >/dev/null 2>&1
echo "reset: button_value='Save & Edit', hide_default_save=0"
