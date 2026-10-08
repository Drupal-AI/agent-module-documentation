#!/usr/bin/env bash
# Execution CLEANUP: delete 'VUA Del Node' (cascades any alias + mapping row). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title","VUA Del Node")->accessCheck(FALSE)->execute();
  foreach ($ids as $id) { if ($n = Node::load($id)) { $n->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'VUA Del Node' removed"
