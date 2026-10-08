#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults for the touched keys (env=dev, whisper
# ban_duration=3600). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("crowdsec.settings")
    ->set("env", "dev")
    ->set("plugins.whisper.ban_duration", 3600)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: crowdsec.settings env=dev, plugins.whisper.ban_duration=3600 (defaults)"
