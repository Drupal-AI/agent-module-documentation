#!/usr/bin/env bash
# Execution RESET / CLEANUP: restore geoblock.settings to its shipped defaults so any verify
# expecting a configured restriction FAILS on this baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("geoblock.settings")
    ->set("applicable_methods", ["CONNECT", "DELETE", "PATCH", "POST", "PUT"])
    ->set("data_source", "")
    ->set("enable_logging", FALSE)
    ->set("require_domestic_use", FALSE)
    ->set("restriction_country_codes", [])
    ->set("restriction_type", "")
    ->save();
' >/dev/null 2>&1
echo "reset: geoblock.settings restored to shipped defaults"
