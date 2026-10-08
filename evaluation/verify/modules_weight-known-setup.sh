#!/usr/bin/env bash
# Introspection SETUP (modules_weight): set a known weight (7) on the modules_weight module
# itself and enable the show_system_modules option, so an inspecting agent can read both back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  module_set_weight("modules_weight", 7);
  \Drupal::configFactory()->getEditable("modules_weight.settings")->set("show_system_modules", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: modules_weight weight=7 in core.extension; show_system_modules=TRUE"
