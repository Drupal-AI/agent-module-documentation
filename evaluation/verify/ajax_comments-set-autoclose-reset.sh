#!/usr/bin/env bash
# Execution RESET: set shipped defaults (reply_autoclose=false, notify=true) so verify FAILS until
# the agent enables autoclose and disables notify. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ajax_comments.settings")->set("notify", TRUE)->set("enable_scroll", TRUE)->set("reply_autoclose", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ajax_comments defaults (reply_autoclose=false, notify=true)"
