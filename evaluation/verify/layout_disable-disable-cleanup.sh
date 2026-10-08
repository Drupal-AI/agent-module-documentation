#!/usr/bin/env bash
# Execution CLEANUP: clear the disabled-layouts list (re-enable everything). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("layout_disable.settings");
  $c->clear("disabled_layouts")->save();
  \Drupal::service("plugin.manager.core.layout")->clearCachedDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: disabled_layouts cleared"
