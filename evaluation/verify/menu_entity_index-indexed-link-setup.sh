#!/usr/bin/env bash
# Introspection SETUP: track node+main, create an Article node and a menu link in the
# 'main' menu that references it, then rebuild the index so a row exists. The agent must
# inspect the live menu_entity_index table to report which menu the reference is in. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $c = \Drupal::configFactory()->getEditable("menu_entity_index.configuration");
  $c->set("all_menus", FALSE)->set("menus", ["main" => "main"])->set("entity_types", ["node" => "node"])->save();
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "MEI Introspect Target"]);
  $node = $nodes ? reset($nodes) : NULL;
  if (!$node) {
    $node = Node::create(["type" => "article", "title" => "MEI Introspect Target", "status" => 1]);
    $node->save();
  }
  $links = \Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["title" => "MEI Introspect Menu Link"]);
  if (!$links) {
    MenuLinkContent::create([
      "title" => "MEI Introspect Menu Link",
      "link" => ["uri" => "internal:/node/" . $node->id()],
      "menu_name" => "main",
    ])->save();
  }
' >/dev/null 2>&1
drush menu-entity-index:rebuild-index main >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: main-menu link 'MEI Introspect Menu Link' -> node 'MEI Introspect Target' indexed"
