#!/usr/bin/env bash
# Introspection CLEANUP: delete the "FB Known Listing" dir_listing node created by setup
# (also drops its filebrowser_nodes row). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("type","dir_listing")->condition("title","FB Known Listing")->execute();
  if ($ids) { foreach (\Drupal\node\Entity\Node::loadMultiple($ids) as $n) { $n->delete(); } }
' >/dev/null 2>&1
echo "cleanup: 'FB Known Listing' removed"
