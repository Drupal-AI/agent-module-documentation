#!/usr/bin/env bash
# Introspection SETUP: add a known custom host to media_qualtrics allowed_hosts so an agent
# can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_qualtrics.settings")
    ->set("allowed_hosts", ["https://qualtrics.com", "https://mq-known.qualtrics.example.com"])
    ->save();
' >/dev/null 2>&1
echo "setup: media_qualtrics.settings allowed_hosts includes https://mq-known.qualtrics.example.com"
