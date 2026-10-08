#!/usr/bin/env bash
# MEDIUM setup: set genpass_mode to a KNOWN non-default value (1 = optional entry).
# Default install value is 2 (restricted).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("genpass.settings")->set("genpass_mode", 1)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: genpass_mode = 1 (optional)"
