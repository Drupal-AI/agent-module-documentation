#!/usr/bin/env bash
# Execution RESET: restore the default warning-modal title and text (text contains the @count
# countdown placeholder), so verify FAILS until the agent sets the required custom title. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("inactive_autologout.settings")
    ->set("modal_title", "Session Expiring")
    ->set("modal_text", "You will be logged out in <span id=\"autologout-countdown-number\" class=\"countdown-number\">@count</span> seconds due to inactivity.")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: inactive_autologout modal_title=Session Expiring (default), modal_text default"
