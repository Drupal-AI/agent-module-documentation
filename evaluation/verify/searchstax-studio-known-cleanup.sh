#!/usr/bin/env bash
# MEDIUM introspection cleanup: restore the SearchStudio-related searchstax.settings keys.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("searchstax.settings")
    ->set("searches_via_searchstudio", FALSE)
    ->set("analytics_url", "https://app.searchstax.com")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: searchstax SearchStudio settings restored to install defaults"
