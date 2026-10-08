#!/usr/bin/env bash
# HARD execution reset: remove any Google Programmable Search page so the "create and
# configure a google_cse search page" task starts from a missing (failing) state. Deletes
# every search.page config entity whose plugin is google_cse_search (leaves core
# node_search / user_search untouched).
set -uo pipefail
cd /var/www/html
drush php:eval '
foreach (\Drupal::entityTypeManager()->getStorage("search_page")->loadMultiple() as $p) {
  if ($p->getPlugin()->getPluginId() === "google_cse_search") { $p->delete(); }
}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all google_cse_search search pages removed"
