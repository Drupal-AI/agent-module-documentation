#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ajax_comments.settings")->set("notify", TRUE)->set("enable_scroll", TRUE)->set("reply_autoclose", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ajax_comments defaults restored"
