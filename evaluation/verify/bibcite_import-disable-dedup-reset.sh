#!/usr/bin/env bash
# Execution RESET: set BOTH deduplication toggles ON so verify (wants both OFF) FAILS. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite_import.settings")
    ->set("settings.contributor_deduplication", TRUE)->set("settings.keyword_deduplication", TRUE)->save();
' >/dev/null 2>&1
echo "reset: both dedup toggles ON"
