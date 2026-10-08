#!/usr/bin/env bash
# Introspection SETUP: change ONLY reply_autoclose from its default (false) to true. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ajax_comments.settings")->set("notify", TRUE)->set("enable_scroll", TRUE)->set("reply_autoclose", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ajax_comments reply_autoclose=true (only change from default)"
