#!/usr/bin/env bash
# Introspection cleanup: restore realname.settings:pattern to the install default.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("realname.settings")->set("pattern", "[user:account-name]")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: realname.settings pattern restored to [user:account-name]"
