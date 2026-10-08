#!/usr/bin/env bash
# Introspection SETUP: set the parent menu link selector to 'cshs' so an agent can read it back.
# (Safe even without the cshs module: the service override only activates when cshs is enabled.) Exit 0.
set -uo pipefail
cd /var/www/html
drush cset menu_link_weight.settings menu_parent_form_selector cshs -y >/dev/null 2>&1
echo "setup: menu_link_weight.settings menu_parent_form_selector = cshs"
