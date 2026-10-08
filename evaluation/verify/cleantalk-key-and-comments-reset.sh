#!/usr/bin/env bash
# HARD reset: clear cleantalk.settings so the "set key + protect comments & registration"
# task starts from a failing state — empty Access key and both those form checks OFF.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cleantalk.settings")
    ->set("cleantalk_authkey", "")
    ->set("cleantalk_check_comments", FALSE)
    ->set("cleantalk_check_register", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cleantalk_authkey cleared; comment + registration checks OFF"
