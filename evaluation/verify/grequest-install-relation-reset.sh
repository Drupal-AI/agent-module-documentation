#!/usr/bin/env bash
# Execution RESET: ensure group type grequest_htype exists WITHOUT the group_membership_request
# relation (remove it if present), so verify FAILS until the agent installs the plugin.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  $gt = GroupType::load("grequest_htype") ?: GroupType::create(["id"=>"grequest_htype","label"=>"Grequest HType","creator_membership"=>FALSE]);
  $gt->save();
  $s = \Drupal::entityTypeManager()->getStorage("group_relationship_type");
  if (!$gt->hasPlugin("group_membership")) { $s->createFromPlugin($gt,"group_membership")->save(); }
  $rtid = $s->getRelationshipTypeId("grequest_htype","group_membership_request");
  if ($rt = \Drupal\group\Entity\GroupRelationshipType::load($rtid)) { $rt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: group type grequest_htype WITHOUT group_membership_request"
