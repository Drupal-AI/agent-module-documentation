#!/usr/bin/env bash
# Execution CLEANUP: delete the 'PC Task Node' node. Deleting the node automatically drops its
# own node_access grant records, so no full node_access_rebuild() is needed (a global rebuild is
# both slow and unsafe on a shared site). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (\Drupal::entityQuery("node")->condition("title","PC Task Node")->accessCheck(FALSE)->execute() as $nid) { Node::load($nid)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'PC Task Node' removed (its node_access records dropped with it)"
