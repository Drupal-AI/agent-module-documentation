#!/usr/bin/env bash
# Introspection SETUP: set frontend_editing.settings sidebar_width to a known sentinel (42)
# so an inspecting agent can read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("frontend_editing.settings")->set("sidebar_width", 42)->save();' >/dev/null 2>&1
echo "setup: frontend_editing.settings sidebar_width=42"
