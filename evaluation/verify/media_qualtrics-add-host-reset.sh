#!/usr/bin/env bash
# Execution RESET: restore shipped default allowed_hosts (so the task host is absent and verify
# FAILS until the agent adds it). Also usable as cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_qualtrics.settings")
    ->set("allowed_hosts", ["https://qualtrics.com"])
    ->save();
' >/dev/null 2>&1
echo "reset: media_qualtrics.settings allowed_hosts = [https://qualtrics.com]"
