#!/usr/bin/env bash
# Introspection CLEANUP: clear layout_overrides and rebuild layout defs. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_options.settings")->set("layout_overrides", [])->save();
  \Drupal::service("plugin.manager.core.layout")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "cleanup: layout_overrides cleared"
