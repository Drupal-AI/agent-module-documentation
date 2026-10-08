#!/usr/bin/env bash
# Execution RESET: ensure node 'CS Deploy Node' exists and delete any Export entity named
# 'CS Deploy Set' (so verify FAILS until the agent builds it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\content_synchronizer\Entity\ExportEntity;
  if (!\Drupal::entityQuery("node")->condition("title","CS Deploy Node")->accessCheck(FALSE)->execute()) {
    Node::create(["type"=>"article","title"=>"CS Deploy Node","status"=>1])->save();
  }
  foreach (ExportEntity::loadMultiple() as $e) { if ($e->getName() === "CS Deploy Set") { \Drupal::database()->delete("content_synchronizer_export_items")->condition("export_id",$e->id())->execute(); $e->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node 'CS Deploy Node' present, export 'CS Deploy Set' absent"
