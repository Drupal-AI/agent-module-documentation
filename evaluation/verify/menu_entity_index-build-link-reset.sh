#!/usr/bin/env bash
# Execution RESET: configure tracking (node + main menu), ensure an Article node titled
# 'MEI Hard Target' exists, and remove any existing menu link to it plus its index rows,
# so verify FAILS until the agent creates a main-menu link referencing that node. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $c = \Drupal::configFactory()->getEditable("menu_entity_index.configuration");
  $c->set("all_menus", FALSE)->set("menus", ["main" => "main"])->set("entity_types", ["node" => "node"])->save();
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "MEI Hard Target"]);
  $node = $nodes ? reset($nodes) : NULL;
  if (!$node) {
    $node = Node::create(["type" => "article", "title" => "MEI Hard Target", "status" => 1]);
    $node->save();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["title" => "MEI Hard Menu Link"]) as $l) {
    $l->delete();
  }
  \Drupal::database()->delete("menu_entity_index")->condition("target_type", "node")->condition("target_id", $node->id())->execute();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tracking on (node+main); node 'MEI Hard Target' present with no indexed menu link"
