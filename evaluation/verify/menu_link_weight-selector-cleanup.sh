#!/usr/bin/env bash
# CLEANUP (shared): restore the shipped default parent selector. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset menu_link_weight.settings menu_parent_form_selector default -y >/dev/null 2>&1
echo "cleanup: menu_link_weight.settings menu_parent_form_selector = default"
