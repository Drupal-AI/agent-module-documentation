#!/usr/bin/env bash
# Execution CLEANUP: remove the audit state keys. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush state:delete mdft_audit_lifecycle >/dev/null 2>&1 || true
drush state:delete mdft_audit_installed >/dev/null 2>&1 || true
echo "cleanup: audit state keys removed"
