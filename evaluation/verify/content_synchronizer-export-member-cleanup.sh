#!/usr/bin/env bash
# Introspection CLEANUP: remove the 'CS Node Set' export and the 'CS Payload Node' node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\content_synchronizer\Entity\ExportEntity;
  foreach (ExportEntity::loadMultiple() as $e) { if ($e->getName() === "CS Node Set") { \Drupal::database()->delete("content_synchronizer_export_items")->condition("export_id",$e->id())->execute(); $e->delete(); } }
  foreach (\Drupal::entityQuery("node")->condition("title","CS Payload Node")->accessCheck(FALSE)->execute() as $nid) { Node::load($nid)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'CS Node Set' export and 'CS Payload Node' node removed"
