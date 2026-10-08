#!/usr/bin/env bash
# Introspection CLEANUP: delete the English override config (baseline: none). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("stringoverrides.string_override.en")->delete();
  \Drupal::configFactory()->getEditable("stringoverrides.string_override.en_disabled")->delete();
  \Drupal::cache()->delete("stringoverides:translation_for_en");
' >/dev/null 2>&1
echo "cleanup: removed stringoverrides.string_override.en"
