#!/usr/bin/env bash
# event_log_track_block_content clear: remove all this submodule's sentinel rows (ELT_BLOCK_MED/ELT_BLOCK_HA/ELT_BLOCK_HB). Used as medium cleanup and hard reset/cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("event_log_track")->condition("ref_char",["ELT_BLOCK_MED","ELT_BLOCK_HA","ELT_BLOCK_HB"],"IN")->execute();' >/dev/null 2>&1
echo "clear: removed BLOCK sentinel rows"
