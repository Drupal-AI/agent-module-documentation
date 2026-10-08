#!/usr/bin/env bash
# Execution CLEANUP: delete group type grequest_htype. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  if ($gt = GroupType::load("grequest_htype")) { $gt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: group type grequest_htype removed"
