#!/usr/bin/env bash
# Execution RESET: DISABLE layout_twocol (two column) so verify FAILS until the agent re-enables it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("layout_disable.settings");
  $c->set("disabled_layouts", ["layout_twocol" => "layout_twocol"])->save();
  \Drupal::service("plugin.manager.core.layout")->clearCachedDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: layout_twocol currently DISABLED"
