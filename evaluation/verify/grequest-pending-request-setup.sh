#!/usr/bin/env bash
# Introspection SETUP: create group type grequest_ptype (+ membership plugins), a group, a user
# grequest_pending_user, and a PENDING membership request from that user, so an agent can inspect
# who has a pending request. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  use Drupal\group\Entity\Group;
  use Drupal\user\Entity\User;
  $gt = GroupType::load("grequest_ptype") ?: GroupType::create(["id"=>"grequest_ptype","label"=>"Grequest PType","creator_membership"=>FALSE]);
  $gt->save();
  $s = \Drupal::entityTypeManager()->getStorage("group_relationship_type");
  if (!$gt->hasPlugin("group_membership")) { $s->createFromPlugin($gt,"group_membership")->save(); }
  if (!$gt->hasPlugin("group_membership_request")) { $s->createFromPlugin($gt,"group_membership_request")->save(); }
  $u = user_load_by_name("grequest_pending_user") ?: User::create(["name"=>"grequest_pending_user","mail"=>"gpu@example.com","status"=>1]);
  $u->save();
  $groups = \Drupal::entityTypeManager()->getStorage("group")->loadByProperties(["type"=>"grequest_ptype","label"=>"Grequest Pending Group"]);
  $g = $groups ? reset($groups) : Group::create(["type"=>"grequest_ptype","label"=>"Grequest Pending Group"]);
  $g->save();
  $mgr = \Drupal::service("grequest.membership_request_manager");
  if (!$mgr->getMembershipRequest($u, $g)) { $req = $mgr->create($g, $u); $req->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: user grequest_pending_user has a pending request in group Grequest Pending Group"
