#!/usr/bin/env bash
# event_log_track_clear_cache clear: remove all this submodule's sentinel rows (ELT_CACHE_MED/ELT_CACHE_HA/ELT_CACHE_HB). Used as medium cleanup and hard reset/cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("event_log_track")->condition("ref_char",["ELT_CACHE_MED","ELT_CACHE_HA","ELT_CACHE_HB"],"IN")->execute();' >/dev/null 2>&1
echo "clear: removed CACHE sentinel rows"
