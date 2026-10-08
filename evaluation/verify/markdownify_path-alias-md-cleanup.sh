#!/usr/bin/env bash
# Execution CLEANUP: re-enable markdownify_path (restore normal state) and remove the probe node
# and its alias. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en markdownify_path -y >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\Node;
  $store = \Drupal::entityTypeManager()->getStorage("path_alias");
  foreach ($store->loadByProperties(["alias"=>"/mmp-md-node"]) as $a) { $a->delete(); }
  foreach (\Drupal::entityQuery("node")->condition("title","MMP MD Node")->accessCheck(FALSE)->execute() as $id) { Node::load($id)?->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: markdownify_path re-enabled; probe node/alias removed"
