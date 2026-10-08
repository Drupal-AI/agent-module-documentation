#!/usr/bin/env bash
# Introspection SETUP: create Article 'node_class candidate A' (no class) and
# 'node_class candidate B' (node_class=nc-b-highlight). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (["node_class candidate A", "node_class candidate B"] as $t) {
    $ids = \Drupal::entityQuery("node")->condition("title", $t)->accessCheck(FALSE)->execute();
    foreach (Node::loadMultiple($ids) as $n) { $n->delete(); }
  }
  Node::create(["type" => "article", "title" => "node_class candidate A", "status" => 1])->save();
  Node::create(["type" => "article", "title" => "node_class candidate B", "node_class" => "nc-b-highlight", "status" => 1])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: candidate A (none), candidate B (nc-b-highlight)"
