#!/usr/bin/env bash
# Introspection CLEANUP: delete the 'VUA Known City' node (cascades its alias + mapping row). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title","VUA Known City")->accessCheck(FALSE)->execute();
  foreach ($ids as $id) { if ($n = Node::load($id)) { $n->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'VUA Known City' removed"
