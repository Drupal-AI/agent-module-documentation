#!/usr/bin/env bash
# Introspection SETUP: build a real OG group (node type og_mgrp), a group node "OG Probe Club",
# a user og_probe_user and an og_membership for them in a NON-default state (pending) carrying
# the administrator OG role - so the answer only exists in the live og_membership entity.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\node\Entity\NodeType;
  use Drupal\user\Entity\User;
  use Drupal\og\Og;
  use Drupal\og\Entity\OgRole;
  use Drupal\og\OgRoleInterface;
  use Drupal\og\OgMembershipInterface;
  if (!NodeType::load("og_mgrp")) { NodeType::create(["type" => "og_mgrp", "name" => "OG Membership Probe Group"])->save(); }
  if (!Og::isGroup("node", "og_mgrp")) { Og::groupTypeManager()->addGroup("node", "og_mgrp"); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $found = $storage->loadByProperties(["title" => "OG Probe Club"]);
  $group = $found ? reset($found) : Node::create(["type" => "og_mgrp", "title" => "OG Probe Club", "uid" => 1]);
  $group->setPublished()->save();
  $user = user_load_by_name("og_probe_user");
  if (!$user) {
    $user = User::create(["name" => "og_probe_user", "mail" => "og_probe_user@example.com", "status" => 1]);
    $user->save();
  }
  $mm = \Drupal::service("og.membership_manager");
  $membership = $mm->getMembership($group, $user->id(), OgMembershipInterface::ALL_STATES);
  if (!$membership) { $membership = Og::createMembership($group, $user); }
  $membership->setState(OgMembershipInterface::STATE_PENDING);
  $membership->addRole(OgRole::loadByGroupAndName($group, OgRoleInterface::ADMINISTRATOR));
  $membership->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: og_probe_user has a PENDING og_membership with the administrator role in 'OG Probe Club'"
