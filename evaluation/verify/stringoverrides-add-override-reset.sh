#!/usr/bin/env bash
# Execution RESET: remove any English overrides so verify FAILS until the agent adds one.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("stringoverrides.string_override.en")->delete();
  \Drupal::configFactory()->getEditable("stringoverrides.string_override.en_disabled")->delete();
  \Drupal::cache()->delete("stringoverides:translation_for_en");
' >/dev/null 2>&1
echo "reset: cleared stringoverrides.string_override.en"
