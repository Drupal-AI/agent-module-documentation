#!/usr/bin/env bash
# Execution RESET: create puphpeteer.settings with executable_path='' so verify FAILS until
# the agent sets it to /usr/bin/node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("puphpeteer.settings")->set("executable_path", "")->save();
' >/dev/null 2>&1
echo "reset: puphpeteer.settings executable_path=''"
