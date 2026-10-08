#!/usr/bin/env bash
# Execution RESET: create group type grequest_atype (+ membership plugins), a group, a user
# grequest_approve_user, and a PENDING request from that user who is NOT yet a member, so verify
# FAILS until the agent approves the request (which makes the user a member). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  use Drupal\group\Entity\Group;
  use Drupal\user\Entity\User;
  $gt = GroupType::load("grequest_atype") ?: GroupType::create(["id"=>"grequest_atype","label"=>"Grequest AType","creator_membership"=>FALSE]);
  $gt->save();
  $s = \Drupal::entityTypeManager()->getStorage("group_relationship_type");
  if (!$gt->hasPlugin("group_membership")) { $s->createFromPlugin($gt,"group_membership")->save(); }
  if (!$gt->hasPlugin("group_membership_request")) { $s->createFromPlugin($gt,"group_membership_request")->save(); }
  $u = user_load_by_name("grequest_approve_user") ?: User::create(["name"=>"grequest_approve_user","mail"=>"gau@example.com","status"=>1]);
  $u->save();
  // fresh group each reset for a clean state
  foreach (\Drupal::entityTypeManager()->getStorage("group")->loadByProperties(["type"=>"grequest_atype"]) as $old) { $old->delete(); }
  $g = Group::create(["type"=>"grequest_atype","label"=>"Grequest Approve Group"]); $g->save();
  $mgr = \Drupal::service("grequest.membership_request_manager");
  $req = $mgr->create($g, $u); $req->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: grequest_approve_user has a pending request, not yet a member of Grequest Approve Group"
