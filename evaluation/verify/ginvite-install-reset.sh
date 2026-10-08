#!/usr/bin/env bash
# Execution RESET: ensure group type gi_task exists but the group_invitation relation is NOT
# installed on it, so verify FAILS until the agent installs it. The group type stays (so its
# auto-created membership relation is never left orphaned). One atomic drush call. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  if (!GroupType::load("gi_task")) { GroupType::create(["id"=>"gi_task","label"=>"GI Task"])->save(); }
  foreach (\Drupal::entityTypeManager()->getStorage("group_relationship_type")->loadByProperties(["group_type"=>"gi_task","content_plugin"=>"group_invitation"]) as $rt) { $rt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: group type gi_task present WITHOUT group_invitation relation"
