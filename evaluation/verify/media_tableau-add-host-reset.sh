#!/usr/bin/env bash
# Execution RESET: force media_tableau allowed_hosts back to only the default host, so verify
# FAILS until the agent whitelists https://mtb-task.example.com. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_tableau.settings")
    ->set("allowed_hosts", ["https://public.tableau.com"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media_tableau.settings allowed_hosts = [public.tableau.com] (task host absent)"
