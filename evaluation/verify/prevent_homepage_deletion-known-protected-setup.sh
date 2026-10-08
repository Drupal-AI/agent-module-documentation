#!/usr/bin/env bash
# Introspection SETUP: create two Articles ("PHD Probe Alpha" and "PHD Probe Beta") and list
# ONLY Alpha's path in prevent_homepage_deletion.settings:protected_urls, so the agent must
# read the live config (and resolve the path to a node) to say which one is protected.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $ids = [];
  foreach (["PHD Probe Alpha", "PHD Probe Beta"] as $title) {
    $found = $storage->loadByProperties(["title" => $title]);
    $node = $found ? reset($found) : Node::create(["type" => "article", "title" => $title, "uid" => 1]);
    $node->setPublished()->save();
    $ids[$title] = $node->id();
  }
  \Drupal::configFactory()->getEditable("prevent_homepage_deletion.settings")
    ->set("protected_urls", "/node/" . $ids["PHD Probe Alpha"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: protected_urls lists only the node path of 'PHD Probe Alpha'"
