#!/usr/bin/env bash
# Introspection SETUP: disable the layout_twocol_bricks layout via layout_disable config so an agent
# can discover which layout is currently disabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("layout_disable.settings");
  $c->set("disabled_layouts", ["layout_twocol_bricks" => "layout_twocol_bricks"])->save();
  \Drupal::service("plugin.manager.core.layout")->clearCachedDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: layout_twocol_bricks disabled via layout_disable"
