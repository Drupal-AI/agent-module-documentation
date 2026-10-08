#!/usr/bin/env bash
# Introspection SETUP: turn OFF real mail delivery (send=false), keep logging on.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("maillog.settings")->set("send", FALSE)->set("log", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: maillog.settings send=false (delivery suppressed), log=true"
