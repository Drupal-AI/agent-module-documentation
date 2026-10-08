#!/usr/bin/env bash
# event_log_track_tfa clear: remove all this submodule's sentinel rows (ELT_TFA_MED/ELT_TFA_HA/ELT_TFA_HB). Used as medium cleanup and hard reset/cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("event_log_track")->condition("ref_char",["ELT_TFA_MED","ELT_TFA_HA","ELT_TFA_HB"],"IN")->execute();' >/dev/null 2>&1
echo "clear: removed TFA sentinel rows"
