#!/usr/bin/env bash
# Introspection SETUP: turn OFF keyword deduplication in bibcite import settings. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite_import.settings")
    ->set("settings.contributor_deduplication", TRUE)->set("settings.keyword_deduplication", FALSE)->save();
' >/dev/null 2>&1
echo "setup: bibcite_import.settings keyword_deduplication=false"
