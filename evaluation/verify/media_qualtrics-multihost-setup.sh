#!/usr/bin/env bash
# Introspection SETUP: configure media_qualtrics with a known multi-host allowed list.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_qualtrics.settings")
    ->set("allowed_hosts", ["https://qualtrics.com", "https://eu.mqknown.example.com", "https://survey.mqknown.example.com"])
    ->save();
' >/dev/null 2>&1
echo "setup: media_qualtrics allowed_hosts = [qualtrics.com, eu.mqknown.example.com, survey.mqknown.example.com]"
