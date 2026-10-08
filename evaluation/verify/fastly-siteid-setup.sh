#!/usr/bin/env bash
# Introspection SETUP: set a known Fastly Site ID so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("fastly.settings")->set("site_id","fastly_probe_site")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: fastly.settings site_id=fastly_probe_site"
