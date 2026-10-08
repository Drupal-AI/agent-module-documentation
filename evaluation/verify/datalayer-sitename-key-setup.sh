#!/usr/bin/env bash
# MEDIUM setup: rename the dataLayer JSON key used for the site name value.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("datalayer.settings")
    ->set("site_name", "siteTitle")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: datalayer.settings site_name = siteTitle"
