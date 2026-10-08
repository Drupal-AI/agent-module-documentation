#!/usr/bin/env bash
# Introspection SETUP: enable a layout override for layout_onecol in layout_options.settings so
# an agent can read the layout_overrides config and report which layout is overridden. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("layout_options.settings")->set("layout_overrides", ["layout_discovery__layout_onecol" => 1])->save();' >/dev/null 2>&1
echo "setup: layout_overrides = {layout_discovery__layout_onecol: 1}"
