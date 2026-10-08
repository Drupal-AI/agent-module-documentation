#!/usr/bin/env bash
# medium SETUP (altcha): set the ALTCHA proof-of-work complexity (max_number) to a known 50000. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("altcha.settings")->set("max_number", 50000)->save();' >/dev/null 2>&1
echo "setup: altcha.settings max_number = 50000"
