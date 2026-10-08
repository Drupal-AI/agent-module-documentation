#!/usr/bin/env bash
# Introspection SETUP: point the DubBot API URL at a distinctive endpoint so the agent must
# inspect live config to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("dubbot.settings")
    ->set("api_url", "https://api.dubbot-probe.example.com")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: dubbot.settings api_url=https://api.dubbot-probe.example.com"
