#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("all_in_one_accessibility.userid.settings")->set("widget_size","oversize")->set("colorcode","#123abc")->save();' >/dev/null 2>&1
echo "setup: all_in_one_accessibility.userid.settings widget_size=oversize colorcode=#123abc"
