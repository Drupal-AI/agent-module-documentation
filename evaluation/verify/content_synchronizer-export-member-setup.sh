#!/usr/bin/env bash
# Introspection SETUP: create a node 'CS Payload Node' and an Export entity 'CS Node Set' that
# contains it, so the agent can inspect which node the export holds. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\content_synchronizer\Entity\ExportEntity;
  $ids = \Drupal::entityQuery("node")->condition("title","CS Payload Node")->accessCheck(FALSE)->execute();
  if ($ids) { $node = Node::load(reset($ids)); }
  else { $node = Node::create(["type"=>"article","title"=>"CS Payload Node","status"=>1]); $node->save(); }
  foreach (ExportEntity::loadMultiple() as $e) { if ($e->getName() === "CS Node Set") { \Drupal::database()->delete("content_synchronizer_export_items")->condition("export_id",$e->id())->execute(); $e->delete(); } }
  $ex = ExportEntity::create(["name"=>"CS Node Set","user_id"=>1,"status"=>1]);
  $ex->save();
  $ex->addEntity($node);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: export_entity 'CS Node Set' contains node 'CS Payload Node'"
