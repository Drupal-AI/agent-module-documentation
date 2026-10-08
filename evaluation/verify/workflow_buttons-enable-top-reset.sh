#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("workflow_buttons.settings")->set("display.top_buttons", FALSE)->save();' >/dev/null 2>&1
echo "reset: display.top_buttons=false"
