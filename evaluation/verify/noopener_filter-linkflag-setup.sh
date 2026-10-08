#!/usr/bin/env bash
# Introspection SETUP: turn ON the global link-alter flag (noopener_filter.settings:filter_links)
# so an inspecting agent can read back that Drupal-generated new-tab links are being rewritten.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("noopener_filter.settings")->set("filter_links", 1)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: noopener_filter.settings:filter_links = 1"
