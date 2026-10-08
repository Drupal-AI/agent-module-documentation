#!/usr/bin/env bash
# MEDIUM introspection setup: route searches through SearchStudio and pin a known analytics
# URL so the agent can read them back from live config. Restored by the -cleanup script.
# No SearchStax network access required — this only touches the searchstax.settings config.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("searchstax.settings")
    ->set("searches_via_searchstudio", TRUE)
    ->set("analytics_url", "https://known-studio.eval.searchstax.com")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: searchstax searches_via_searchstudio=TRUE, analytics_url=https://known-studio.eval.searchstax.com"
