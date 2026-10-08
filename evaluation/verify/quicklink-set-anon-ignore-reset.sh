#!/usr/bin/env bash
# Execution RESET: force no_load_when_authenticated FALSE and clear url_patterns_to_ignore, so
# verify FAILS until the agent enables anonymous-only + adds the ignore pattern. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("quicklink.settings")->set("no_load_when_authenticated", FALSE)->set("url_patterns_to_ignore", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: quicklink no_load_when_authenticated=FALSE, url_patterns_to_ignore=''"
