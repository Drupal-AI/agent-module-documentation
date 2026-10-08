#!/usr/bin/env bash
# Execution CLEANUP: clear layout_overrides. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("layout_options.settings")->set("layout_overrides", [])->save();' >/dev/null 2>&1
echo "cleanup: layout_overrides cleared"
