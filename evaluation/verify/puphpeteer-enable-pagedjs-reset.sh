#!/usr/bin/env bash
# Execution RESET: create puphpeteer.settings with pagedjs=FALSE so verify FAILS until the
# agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("puphpeteer.settings")->set("pagedjs", FALSE)->save();
' >/dev/null 2>&1
echo "reset: puphpeteer.settings pagedjs=false"
