#!/usr/bin/env bash
# Execution RESET: force the selector to 'cshs' so verify FAILS until the agent sets it back to default. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset menu_link_weight.settings menu_parent_form_selector cshs -y >/dev/null 2>&1
echo "reset: menu_parent_form_selector = cshs"
