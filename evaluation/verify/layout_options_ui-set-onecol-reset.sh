#!/usr/bin/env bash
# Execution RESET: clear layout_overrides so verify FAILS until the agent overrides layout_onecol.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("layout_options.settings")->set("layout_overrides", [])->save();' >/dev/null 2>&1
echo "reset: layout_overrides cleared"
