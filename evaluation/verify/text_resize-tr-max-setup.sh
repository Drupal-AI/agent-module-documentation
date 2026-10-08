#!/usr/bin/env bash
# Introspection SETUP: set a known maximum font size.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("text_resize.settings")->set("text_resize_maximum",40)->save();' >/dev/null 2>&1
echo "setup: text_resize_maximum=40"
