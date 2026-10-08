#!/usr/bin/env bash
# Introspection setup: install a KNOWN realname pattern to the live site so the agent can
# read it back. Sets realname.settings:pattern to a distinctive email-based pattern.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("realname.settings")->set("pattern", "[user:mail]")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: realname.settings pattern -> [user:mail]"
