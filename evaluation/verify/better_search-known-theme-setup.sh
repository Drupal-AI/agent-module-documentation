#!/usr/bin/env bash
# Introspection SETUP: set animation theme to 3 (Slide Icon on Hover) so an agent can read the
# active style from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("better_search.settings")->set("theme", 3)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: better_search.settings theme=3 (Slide Icon on Hover)"
