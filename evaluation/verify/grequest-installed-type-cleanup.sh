#!/usr/bin/env bash
# Introspection CLEANUP: delete group type grequest_mtype (also removes its relationship types).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  if ($gt = GroupType::load("grequest_mtype")) { $gt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: group type grequest_mtype removed"
