#!/usr/bin/env bash
# Execution RESET: ensure content type bnic_land exists and UNPUBLISH all its nodes, so verify
# FAILS (no published bnic_land node) until the agent creates/publishes one. Nodes are unpublished
# rather than deleted because this shared site currently has an orphaned node field storage that
# breaks node deletion. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("bnic_land")) { NodeType::create(["type" => "bnic_land", "name" => "BNIC Land"])->save(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => "bnic_land"]) as $n) {
    if ($n->isPublished()) { $n->setUnpublished()->save(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: content type bnic_land present, its nodes unpublished"
