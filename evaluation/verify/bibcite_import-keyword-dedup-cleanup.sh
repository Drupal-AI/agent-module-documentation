#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite_import.settings")
    ->set("settings.contributor_deduplication", TRUE)->set("settings.keyword_deduplication", TRUE)->save();
' >/dev/null 2>&1
echo "cleanup: bibcite_import.settings dedup toggles reset to true"
