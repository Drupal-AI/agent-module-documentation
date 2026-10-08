#!/usr/bin/env bash
# Execution CLEANUP: remove the created node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title", "node_class new post")->accessCheck(FALSE)->execute();
  foreach (Node::loadMultiple($ids) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'node_class new post' removed"
