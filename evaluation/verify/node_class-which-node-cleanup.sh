#!/usr/bin/env bash
# Introspection CLEANUP: remove both candidate nodes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (["node_class candidate A", "node_class candidate B"] as $t) {
    $ids = \Drupal::entityQuery("node")->condition("title", $t)->accessCheck(FALSE)->execute();
    foreach (Node::loadMultiple($ids) as $n) { $n->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: candidate A/B removed"
