#!/usr/bin/env bash
# Introspection CLEANUP: delete the sna_known_node node and its aliases. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("title", "sna_known_node")->execute();
  foreach ($ids as $nid) {
    foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["path" => "/node/" . $nid]) as $pa) { $pa->delete(); }
    if ($n = Node::load($nid)) { $n->delete(); }
  }
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "cleanup: sna_known_node and its aliases removed"
