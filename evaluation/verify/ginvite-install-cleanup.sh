#!/usr/bin/env bash
# Execution CLEANUP: remove group type gi_task and ALL of its relationship types (invitation AND the
# auto-created membership) plus any groups, in ONE atomic drush call so nothing is left orphaned
# (an orphaned group_relationship_type whose group type is gone breaks route rebuilds site-wide on
# this install). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  $etm = \Drupal::entityTypeManager();
  foreach ($etm->getStorage("group")->loadByProperties(["type"=>"gi_task"]) as $g) { $g->delete(); }
  foreach ($etm->getStorage("group_relationship_type")->loadByProperties(["group_type"=>"gi_task"]) as $rt) { $rt->delete(); }
  if ($gt = GroupType::load("gi_task")) { $gt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: group type gi_task and all its relationship types removed"
