#!/usr/bin/env bash
# MEDIUM introspection cleanup: remove the Google Programmable Search page staged by
# google_cse-layout-setup.sh, restoring the baseline (no google_cse search page).
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("search_page")->load("google_eval_layout");
if ($s) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: search.page.google_eval_layout removed"
