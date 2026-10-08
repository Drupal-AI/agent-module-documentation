#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("all_in_one_accessibility.userid.settings")->set("userid","AIOA-EVAL-TOKEN-123")->set("position","bottom_left")->save();' >/dev/null 2>&1
echo "setup: all_in_one_accessibility.userid.settings userid=AIOA-EVAL-TOKEN-123 position=bottom_left"
