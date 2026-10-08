#!/usr/bin/env bash
# Introspection SETUP: create an OG group type ogp_mgrp with TWO group nodes ("OGP Probe Alpha"
# and "OGP Probe Beta") and a user ogp_probe_user who is an ACTIVE member of Alpha only - the
# exact input to og_prepopulate's Og::isMember() rule. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en og_prepopulate -y >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\node\Entity\NodeType;
  use Drupal\user\Entity\User;
  use Drupal\og\Og;
  use Drupal\og\OgMembershipInterface;
  if (!NodeType::load("ogp_mgrp")) { NodeType::create(["type" => "ogp_mgrp", "name" => "OGP Membership Probe Group"])->save(); }
  if (!Og::isGroup("node", "ogp_mgrp")) { Og::groupTypeManager()->addGroup("node", "ogp_mgrp"); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $groups = [];
  foreach (["OGP Probe Alpha", "OGP Probe Beta"] as $title) {
    $found = $storage->loadByProperties(["title" => $title]);
    $node = $found ? reset($found) : Node::create(["type" => "ogp_mgrp", "title" => $title, "uid" => 0]);
    $node->setPublished()->save();
    $groups[$title] = $node;
  }
  $user = user_load_by_name("ogp_probe_user");
  if (!$user) {
    $user = User::create(["name" => "ogp_probe_user", "mail" => "ogp_probe_user@example.com", "status" => 1]);
    $user->save();
  }
  $mm = \Drupal::service("og.membership_manager");
  // Remove any membership in Beta, ensure an active one in Alpha.
  $beta = $mm->getMembership($groups["OGP Probe Beta"], $user->id(), OgMembershipInterface::ALL_STATES);
  if ($beta) { $beta->delete(); }
  if (!$mm->getMembership($groups["OGP Probe Alpha"], $user->id(), OgMembershipInterface::ALL_STATES)) {
    Og::createMembership($groups["OGP Probe Alpha"], $user)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ogp_probe_user is an active member of 'OGP Probe Alpha' but not of 'OGP Probe Beta'"
