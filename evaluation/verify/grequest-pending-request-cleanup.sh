#!/usr/bin/env bash
# Introspection CLEANUP: delete the pending group, the user, and the group type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  foreach (\Drupal::entityTypeManager()->getStorage("group")->loadByProperties(["type"=>"grequest_ptype"]) as $g) { $g->delete(); }
  if ($u = user_load_by_name("grequest_pending_user")) { $u->delete(); }
  if ($gt = GroupType::load("grequest_ptype")) { $gt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: grequest_ptype group/user/type removed"
