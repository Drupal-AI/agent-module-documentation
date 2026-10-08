#!/usr/bin/env bash
# HARD execution reset: return the SearchStudio re-routing / analytics-key searchstax.settings
# keys to install defaults so the build task starts from a clean, failing state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("searchstax.settings")
    ->set("searches_via_searchstudio", FALSE)
    ->set("analytics_key", NULL)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: searchstax searches_via_searchstudio=FALSE, analytics_key cleared"
