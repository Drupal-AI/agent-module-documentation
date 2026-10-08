#!/usr/bin/env bash
# Introspection SETUP: disable the three-column 25/50/25 layout so an agent can identify it as the
# disabled layout by inspecting the running layout plugin list. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("layout_disable.settings");
  $c->set("disabled_layouts", ["layout_threecol_25_50_25" => "layout_threecol_25_50_25"])->save();
  \Drupal::service("plugin.manager.core.layout")->clearCachedDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: layout_threecol_25_50_25 disabled via layout_disable"
