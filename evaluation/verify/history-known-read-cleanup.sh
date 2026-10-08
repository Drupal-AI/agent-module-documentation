#!/usr/bin/env bash
# Introspection CLEANUP: delete the history row and the node created by the matching setup.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "History Known Node")->execute();
  foreach ($ids as $nid) {
    \Drupal::database()->delete("history")->condition("nid", $nid)->execute();
  }
  foreach (Node::loadMultiple($ids) as $n) { $n->delete(); }
' >/dev/null 2>&1
echo "cleanup: History Known Node and its {history} rows removed"
