#!/usr/bin/env bash
# Execution RESET: set the 4xx-scan (whisper) threshold (bucket_capacity) back to the default 10, so
# verify FAILS until the agent raises it to 25. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("crowdsec.settings")
    ->set("plugins.whisper.bucket_capacity", 10)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: crowdsec.settings plugins.whisper.bucket_capacity=10 (default)"
