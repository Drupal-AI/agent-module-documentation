#!/usr/bin/env bash
# Introspection SETUP: set the Fastly purge method to 'soft' so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("fastly.settings")->set("purge_method","soft")->set("purge_logging",TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: fastly.settings purge_method=soft"
