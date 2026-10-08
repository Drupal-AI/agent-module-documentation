#!/usr/bin/env bash
# Introspection SETUP: set a known text_resize scope and enable the reset button.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("text_resize.settings")->set("text_resize_scope","main-content")->set("text_resize_reset_button",true)->save();' >/dev/null 2>&1
echo "setup: text_resize_scope=main-content, reset_button=true"
