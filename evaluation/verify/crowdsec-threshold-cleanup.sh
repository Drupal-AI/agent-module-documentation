#!/usr/bin/env bash
# Execution CLEANUP: restore the whisper threshold to the shipped default (10). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("crowdsec.settings")
    ->set("plugins.whisper.bucket_capacity", 10)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: crowdsec.settings plugins.whisper.bucket_capacity=10 (default)"
