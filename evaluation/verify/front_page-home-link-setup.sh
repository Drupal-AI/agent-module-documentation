#!/usr/bin/env bash
# Introspection SETUP: set the Front Page 'home link path' to 'welcome' so the agent can read
# it back from front_page.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("front_page.settings")->set("home_link_path", "welcome")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: front_page.settings.home_link_path = welcome"
