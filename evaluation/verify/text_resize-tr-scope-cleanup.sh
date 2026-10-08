#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (scope 'main', reset button off).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("text_resize.settings")->set("text_resize_scope","main")->set("text_resize_reset_button",false)->save();' >/dev/null 2>&1
echo "cleanup: scope/reset_button restored to defaults"
