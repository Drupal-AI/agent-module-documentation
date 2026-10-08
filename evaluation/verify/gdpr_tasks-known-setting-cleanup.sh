#!/usr/bin/env bash
# Introspection CLEANUP: remove the gdpr_tasks.settings config (baseline: unset). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gdpr_tasks.settings")->delete();' >/dev/null 2>&1
echo "cleanup: gdpr_tasks.settings removed"
