#!/usr/bin/env bash
# Introspection CLEANUP: remove the sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_MED_SENTINEL")->execute();' >/dev/null 2>&1
echo "cleanup: ELT_MED_SENTINEL row removed"
