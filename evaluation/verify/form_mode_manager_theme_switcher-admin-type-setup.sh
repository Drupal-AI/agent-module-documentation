#!/usr/bin/env bash
# Introspection SETUP: configure the node.contributor form mode to use the admin theme. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("form_mode_manager_theme_switcher.settings")->set("type.node_contributor","admin")->save();' >/dev/null 2>&1
echo "setup: type.node_contributor = admin"
