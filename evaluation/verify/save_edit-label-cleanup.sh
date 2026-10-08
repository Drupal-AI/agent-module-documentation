#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default button label.
set -uo pipefail
cd /var/www/html
drush cset save_edit.settings button_value 'Save & Edit' -y >/dev/null 2>&1
echo "cleanup: save_edit.settings button_value='Save & Edit'"
