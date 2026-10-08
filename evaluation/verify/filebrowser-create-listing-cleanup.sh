#!/usr/bin/env bash
# Execution CLEANUP: remove the "Filebrowser Eval Share" dir_listing node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("type","dir_listing")->condition("title","Filebrowser Eval Share")->execute();
  if ($ids) { foreach (\Drupal\node\Entity\Node::loadMultiple($ids) as $n) { $n->delete(); } }
' >/dev/null 2>&1
echo "cleanup: 'Filebrowser Eval Share' removed"
