#!/usr/bin/env bash
# Introspection CLEANUP: delete the CBC Known Node article. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title", "CBC Known Node")->accessCheck(FALSE)->execute();
  if ($ids) { foreach (Node::loadMultiple($ids) as $n) { $n->delete(); } }
' >/dev/null 2>&1
echo "cleanup: CBC Known Node removed"
