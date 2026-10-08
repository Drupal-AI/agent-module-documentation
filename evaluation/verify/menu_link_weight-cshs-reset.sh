#!/usr/bin/env bash
# Execution RESET: force the selector back to 'default' so verify FAILS until the agent sets cshs. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset menu_link_weight.settings menu_parent_form_selector default -y >/dev/null 2>&1
echo "reset: menu_parent_form_selector = default"
