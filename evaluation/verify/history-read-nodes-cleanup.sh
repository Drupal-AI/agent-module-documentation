#!/usr/bin/env bash
# Introspection CLEANUP: remove both nodes and their history rows. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", ["History Seen Node", "History Unseen Node"], "IN")->execute();
  if ($ids) { \Drupal::database()->delete("history")->condition("nid", $ids, "IN")->execute(); }
  foreach (Node::loadMultiple($ids) as $n) { $n->delete(); }
' >/dev/null 2>&1
echo "cleanup: History Seen/Unseen nodes and their {history} rows removed"
