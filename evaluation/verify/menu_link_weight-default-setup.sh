#!/usr/bin/env bash
# Introspection SETUP: set the parent menu link selector to the shipped 'default'. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset menu_link_weight.settings menu_parent_form_selector default -y >/dev/null 2>&1
echo "setup: menu_link_weight.settings menu_parent_form_selector = default"
