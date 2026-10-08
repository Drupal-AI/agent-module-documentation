#!/usr/bin/env bash
# Execution RESET: ensure the bibcite_export_multiple action does NOT exist so verify FAILS until
# the agent creates it. Running reset again = cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\system\Entity\Action; if ($a = Action::load("bibcite_export_multiple")) { $a->delete(); }' >/dev/null 2>&1 || true
echo "reset: action bibcite_export_multiple absent"
