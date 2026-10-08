#!/usr/bin/env bash
# Introspection SETUP: set fitvids.settings selectors to a known non-default value so an
# inspecting agent can read back which selector FitVids targets. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fitvids.settings")->set("selectors", ".field--type-text-long")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: fitvids.settings selectors = .field--type-text-long"
