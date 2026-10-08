#!/usr/bin/env bash
# Introspection SETUP: set the state marker that a real (non --configure-only) migrate:upgrade
# run records, and that migrate:upgrade-rollback looks for: migrate_drupal_ui.performed.
# Stored as a KNOWN request timestamp so an inspecting agent can read the key back with drush.
# Safe: this state key is only set by an actual upgrade, absent on a clean site. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->set("migrate_drupal_ui.performed", 1700000000);
' >/dev/null 2>&1
echo "setup: state migrate_drupal_ui.performed set to 1700000000"
