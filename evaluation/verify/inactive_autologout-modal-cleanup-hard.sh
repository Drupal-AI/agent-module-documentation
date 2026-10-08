#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped default modal title and text. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("inactive_autologout.settings")
    ->set("modal_title", "Session Expiring")
    ->set("modal_text", "You will be logged out in <span id=\"autologout-countdown-number\" class=\"countdown-number\">@count</span> seconds due to inactivity.")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: inactive_autologout modal title/text restored to defaults"
