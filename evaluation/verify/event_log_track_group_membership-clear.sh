#!/usr/bin/env bash
# event_log_track_group_membership clear: remove all this submodule's sentinel rows (ELT_GMEMBER_MED/ELT_GMEMBER_HA/ELT_GMEMBER_HB). Used as medium cleanup and hard reset/cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("event_log_track")->condition("ref_char",["ELT_GMEMBER_MED","ELT_GMEMBER_HA","ELT_GMEMBER_HB"],"IN")->execute();' >/dev/null 2>&1
echo "clear: removed GMEMBER sentinel rows"
