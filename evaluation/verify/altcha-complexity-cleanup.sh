#!/usr/bin/env bash
# medium CLEANUP (altcha): restore max_number to its shipped default (null). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("altcha.settings")->set("max_number", NULL)->save();' >/dev/null 2>&1
echo "cleanup: altcha.settings max_number reset to null (default)"
