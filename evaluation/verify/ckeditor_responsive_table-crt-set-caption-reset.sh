#!/usr/bin/env bash
# Execution RESET: clear caption_side so verify FAILS until the agent sets it to 'bottom'.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ckeditor_responsive_table.settings")->clear("caption_side")->save();' >/dev/null 2>&1
echo "reset: caption_side cleared"
