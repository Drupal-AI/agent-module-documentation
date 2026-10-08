#!/usr/bin/env bash
# Introspection SETUP: set the global default resolution strategy resolution_type.default.default
# to "dialog" (shipped default is "inline") so an inspecting agent can read the site-wide default. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("conflict.settings")->set("resolution_type.default.default","dialog")->save();' >/dev/null 2>&1
echo "setup: conflict.settings resolution_type.default.default=dialog"
