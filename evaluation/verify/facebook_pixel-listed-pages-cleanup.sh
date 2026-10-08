#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped facebook_pixel page visibility defaults. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("facebook_pixel.settings")
    ->set("visibility.request_path_mode", "all_pages")
    ->set("visibility.request_path_pages", "/admin\n/admin/*\n/batch\n/node/add*\n/node/*/*\n/user/*/*\n/user/login")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: facebook_pixel page visibility restored to install defaults"
