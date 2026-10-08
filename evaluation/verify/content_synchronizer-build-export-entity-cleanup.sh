#!/usr/bin/env bash
# Execution CLEANUP: remove the 'CS Deploy Set' export and 'CS Deploy Node' node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\content_synchronizer\Entity\ExportEntity;
  foreach (ExportEntity::loadMultiple() as $e) { if ($e->getName() === "CS Deploy Set") { \Drupal::database()->delete("content_synchronizer_export_items")->condition("export_id",$e->id())->execute(); $e->delete(); } }
  foreach (\Drupal::entityQuery("node")->condition("title","CS Deploy Node")->accessCheck(FALSE)->execute() as $nid) { Node::load($nid)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'CS Deploy Set' export and 'CS Deploy Node' node removed"
