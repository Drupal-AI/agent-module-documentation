#!/usr/bin/env bash
# Introspection SETUP: configure the node.editor form mode to use a specific (_custom) theme 'claro'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("form_mode_manager_theme_switcher.settings")->set("type.node_editor","_custom")->set("form_mode.node_editor","claro")->save();' >/dev/null 2>&1
echo "setup: type.node_editor=_custom, form_mode.node_editor=claro"
