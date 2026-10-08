#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore pwa.config start_url to the shipped default '/' so verify FAILS
# until the agent sets '/home'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa.config")->set("start_url","/")->save();' >/dev/null 2>&1
echo "reset: pwa.config start_url=/ (default)"
