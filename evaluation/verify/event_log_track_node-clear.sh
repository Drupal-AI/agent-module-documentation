#!/usr/bin/env bash
# event_log_track_node clear: remove all this submodule's sentinel rows (ELT_NODE_MED/ELT_NODE_HA/ELT_NODE_HB). Used as medium cleanup and hard reset/cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("event_log_track")->condition("ref_char",["ELT_NODE_MED","ELT_NODE_HA","ELT_NODE_HB"],"IN")->execute();' >/dev/null 2>&1
echo "clear: removed NODE sentinel rows"
