#!/usr/bin/env bash
# Execution RESET: set both dedup toggles OFF so verify (wants contributor ON, keyword OFF) FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite_import.settings")
    ->set("settings.contributor_deduplication", FALSE)->set("settings.keyword_deduplication", FALSE)->save();
' >/dev/null 2>&1
echo "reset: both dedup toggles OFF"
