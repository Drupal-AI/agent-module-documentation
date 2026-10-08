#!/usr/bin/env bash
# Introspection SETUP: restrict 403->404 to admin routes and to /user/* as an include list.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("m4032404.settings")
    ->set("admin_only", TRUE)->set("pages", ["/user/*"])->set("negate", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: admin_only=TRUE pages=[/user/*] negate=FALSE"
