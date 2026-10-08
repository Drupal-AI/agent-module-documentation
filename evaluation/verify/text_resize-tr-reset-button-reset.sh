#!/usr/bin/env bash
# Execution RESET: force the reset button OFF so verify FAILS until the agent enables it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("text_resize.settings")->set("text_resize_reset_button",false)->save();' >/dev/null 2>&1
echo "reset: text_resize_reset_button=false"
