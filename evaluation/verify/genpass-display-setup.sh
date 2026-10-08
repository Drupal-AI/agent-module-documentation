#!/usr/bin/env bash
# MEDIUM setup: set genpass_display to a KNOWN non-default value (3 = both admin + user).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("genpass.settings")->set("genpass_display", 3)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: genpass_display = 3 (both)"
