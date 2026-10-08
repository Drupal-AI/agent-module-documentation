#!/usr/bin/env bash
# Introspection SETUP: change ONLY notify from its default (true) to false. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ajax_comments.settings")->set("notify", FALSE)->set("enable_scroll", TRUE)->set("reply_autoclose", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ajax_comments notify=false (only change from default)"
