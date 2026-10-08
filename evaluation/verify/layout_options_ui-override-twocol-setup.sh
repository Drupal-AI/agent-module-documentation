#!/usr/bin/env bash
# Introspection SETUP: enable a layout override for layout_twocol so an agent can read the
# layout_overrides config key/value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("layout_options.settings")->set("layout_overrides", ["layout_discovery__layout_twocol" => 1])->save();' >/dev/null 2>&1
echo "setup: layout_overrides = {layout_discovery__layout_twocol: 1}"
