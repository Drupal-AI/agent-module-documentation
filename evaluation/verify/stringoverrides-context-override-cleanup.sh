#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("stringoverrides.string_override.en")->delete();
  \Drupal::cache()->delete("stringoverides:translation_for_en");
' >/dev/null 2>&1
echo "cleanup: removed stringoverrides.string_override.en"
