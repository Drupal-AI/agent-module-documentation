#!/usr/bin/env bash
# Execution RESET: remove any dir_listing node titled "Filebrowser Eval Share" so verify
# FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("type","dir_listing")->condition("title","Filebrowser Eval Share")->execute();
  if ($ids) { foreach (\Drupal\node\Entity\Node::loadMultiple($ids) as $n) { $n->delete(); } }
' >/dev/null 2>&1
echo "reset: no dir_listing 'Filebrowser Eval Share'"
