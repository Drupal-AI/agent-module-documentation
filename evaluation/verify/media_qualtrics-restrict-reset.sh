#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore a multi-host allowed list so the "restrict to a single host"
# task is not already satisfied (verify FAILS until the agent narrows it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_qualtrics.settings")
    ->set("allowed_hosts", ["https://qualtrics.com", "https://extra.mqtask.example.com"])->save();
' >/dev/null 2>&1
echo "reset: media_qualtrics allowed_hosts = [qualtrics.com, extra.mqtask.example.com]"
