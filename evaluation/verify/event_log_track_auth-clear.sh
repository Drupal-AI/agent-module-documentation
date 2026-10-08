#!/usr/bin/env bash
# event_log_track_auth clear: remove all this submodule's sentinel rows (ELT_AUTH_MED/ELT_AUTH_HA/ELT_AUTH_HB). Used as medium cleanup and hard reset/cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("event_log_track")->condition("ref_char",["ELT_AUTH_MED","ELT_AUTH_HA","ELT_AUTH_HB"],"IN")->execute();' >/dev/null 2>&1
echo "clear: removed AUTH sentinel rows"
