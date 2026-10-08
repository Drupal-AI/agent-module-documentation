#!/usr/bin/env bash
# Introspection SETUP: set CrowdSec to prod environment and the 4xx-scan (whisper) ban duration to
# 7200s, so an inspecting agent can read them back from crowdsec.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("crowdsec.settings")
    ->set("env", "prod")
    ->set("plugins.whisper.ban_duration", 7200)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: crowdsec.settings env=prod, plugins.whisper.ban_duration=7200"
