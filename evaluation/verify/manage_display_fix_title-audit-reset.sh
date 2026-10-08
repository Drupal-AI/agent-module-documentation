#!/usr/bin/env bash
# Execution RESET: clear the two Drupal state keys the audit case must produce, so verify FAILS
# on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush state:delete mdft_audit_lifecycle >/dev/null 2>&1 || true
drush state:delete mdft_audit_installed >/dev/null 2>&1 || true
echo "reset: state keys mdft_audit_lifecycle and mdft_audit_installed cleared"
