#!/usr/bin/env bash
# Introspection setup: install a KNOWN composite realname pattern to the live site so the
# agent can read it back. Sets a login-name-plus-uid pattern with literal decoration.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("realname.settings")->set("pattern", "[user:account-name] (#[user:uid])")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: realname.settings pattern -> [user:account-name] (#[user:uid])"
