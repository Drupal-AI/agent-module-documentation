#!/usr/bin/env bash
# Introspection SETUP: set tagclouds page_amount=33 and display_type=count. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tagclouds.settings")->set("page_amount","33")->set("display_type","count")->save();' >/dev/null 2>&1
echo "setup: tagclouds.settings page_amount=33 display_type=count"
