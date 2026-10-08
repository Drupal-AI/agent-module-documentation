#!/usr/bin/env bash
# Execution RESET: ensure contributor role 'bibcite_reviewer' does NOT exist so verify FAILS until
# the agent creates it. Running reset again after the task = cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\bibcite_entity\Entity\ContributorRole;
  if ($r = ContributorRole::load("bibcite_reviewer")) { $r->delete(); }
' >/dev/null 2>&1 || true
echo "reset: bibcite_contributor_role bibcite_reviewer absent"
