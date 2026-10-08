#!/usr/bin/env bash
# Introspection SETUP: turn OFF contributor deduplication in bibcite import settings so an agent
# can read the live value. Keyword dedup stays on. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite_import.settings")
    ->set("settings.contributor_deduplication", FALSE)->set("settings.keyword_deduplication", TRUE)->save();
' >/dev/null 2>&1
echo "setup: bibcite_import.settings contributor_deduplication=false, keyword_deduplication=true"
