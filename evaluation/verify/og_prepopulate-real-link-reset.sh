#!/usr/bin/env bash
# Execution RESET: build a real OG pair (node type ogp_lgrp registered as a group with the group
# node "OGP Link Group", and node type ogp_lcontent carrying the og_audience field), then delete
# any menu link titled "OG Prepopulate Eval Link" so verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en og_prepopulate -y >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\node\Entity\NodeType;
  use Drupal\og\Og;
  use Drupal\og\OgGroupAudienceHelperInterface;
  foreach (["ogp_lgrp" => "OGP Link Group Type", "ogp_lcontent" => "OGP Link Group Content"] as $id => $label) {
    if (!NodeType::load($id)) { NodeType::create(["type" => $id, "name" => $label])->save(); }
  }
  if (!Og::isGroup("node", "ogp_lgrp")) { Og::groupTypeManager()->addGroup("node", "ogp_lgrp"); }
  Og::createField(OgGroupAudienceHelperInterface::DEFAULT_FIELD, "node", "ogp_lcontent");
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $found = $storage->loadByProperties(["title" => "OGP Link Group"]);
  $group = $found ? reset($found) : Node::create(["type" => "ogp_lgrp", "title" => "OGP Link Group", "uid" => 1]);
  $group->setPublished()->save();
  foreach (\Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["title" => "OG Prepopulate Eval Link"]) as $link) {
    $link->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: OG pair ogp_lgrp/ogp_lcontent ready, group node 'OGP Link Group' exists, menu link deleted"
