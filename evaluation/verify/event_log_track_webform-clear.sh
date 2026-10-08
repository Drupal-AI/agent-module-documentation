#!/usr/bin/env bash
# event_log_track_webform clear: remove all this submodule's sentinel rows (ELT_WEBFORM_MED/ELT_WEBFORM_HA/ELT_WEBFORM_HB). Used as medium cleanup and hard reset/cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("event_log_track")->condition("ref_char",["ELT_WEBFORM_MED","ELT_WEBFORM_HA","ELT_WEBFORM_HB"],"IN")->execute();' >/dev/null 2>&1
echo "clear: removed WEBFORM sentinel rows"
