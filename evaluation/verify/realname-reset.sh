#!/usr/bin/env bash
# Reset Real Name to a clean, known-NON-target baseline between eval runs so each hard
# execution case starts failing: set the pattern to a distinctive placeholder that matches
# none of the target patterns, and clear the cached {realname} rows so nothing is stale.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("realname.settings")->set("pattern", "[user:uid]")->save();
  if (function_exists("realname_delete_all")) { realname_delete_all(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: realname.settings pattern -> [user:uid], cached names cleared"
