#!/usr/bin/env bash
# Introspection SETUP: create a group type grequest_mtype with the group_membership_request
# relation installed, so an agent can discover which group type offers membership requests.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  $gt = GroupType::load("grequest_mtype") ?: GroupType::create(["id"=>"grequest_mtype","label"=>"Grequest MType","creator_membership"=>FALSE]);
  $gt->save();
  $s = \Drupal::entityTypeManager()->getStorage("group_relationship_type");
  if (!$gt->hasPlugin("group_membership")) { $s->createFromPlugin($gt,"group_membership")->save(); }
  if (!$gt->hasPlugin("group_membership_request")) { $s->createFromPlugin($gt,"group_membership_request")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: group type grequest_mtype has group_membership_request installed"
