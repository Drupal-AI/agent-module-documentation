#!/usr/bin/env bash
# Introspection SETUP: set the gdpr_tasks Right-to-be-Forgotten export directory config so an
# inspecting agent can read it back. Route-rebuild-free (simple config). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gdpr_tasks.settings")
    ->set("export_directory", "private://gdpr-eval-export")->save();
' >/dev/null 2>&1
echo "setup: gdpr_tasks.settings export_directory=private://gdpr-eval-export"
