#!/usr/bin/env bash
# Introspection SETUP: set a known value in quicklink.settings.url_patterns_to_ignore so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("quicklink.settings")->set("url_patterns_to_ignore", "qlk_secret_path")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: quicklink.settings url_patterns_to_ignore=qlk_secret_path"
