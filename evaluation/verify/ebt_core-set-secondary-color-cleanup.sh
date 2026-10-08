#!/usr/bin/env bash
# Execution CLEANUP: restore baseline (empty secondary color, the shipped state). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ebt_core.settings")->set("ebt_core_secondary_color","")->save();' >/dev/null 2>&1
echo "cleanup: ebt_core_secondary_color reset to empty"
