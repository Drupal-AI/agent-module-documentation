#!/usr/bin/env bash
# Execution CLEANUP: delete 'VUA Task Node' (cascades alias + mapping row). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title","VUA Task Node")->accessCheck(FALSE)->execute();
  foreach ($ids as $id) { if ($n = Node::load($id)) { $n->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'VUA Task Node' removed"
