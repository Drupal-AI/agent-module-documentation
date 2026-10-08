#!/usr/bin/env bash
# Execution CLEANUP: delete the group(s), the user, and the group type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  foreach (\Drupal::entityTypeManager()->getStorage("group")->loadByProperties(["type"=>"grequest_atype"]) as $g) { $g->delete(); }
  if ($u = user_load_by_name("grequest_approve_user")) { $u->delete(); }
  if ($gt = GroupType::load("grequest_atype")) { $gt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: grequest_atype group/user/type removed"
