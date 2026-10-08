#!/usr/bin/env bash
# MEDIUM introspection setup: create an Article node whose Layout Builder override contains a
# block styled by Layout Builder Blocks (a Bootstrap Styles background color 'bg-info' stored
# under the component's bootstrap_styles.block_style). The agent must inspect the live layout
# data to report the applied class. Cleanup deletes the node and reverts the display.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->enableLayoutBuilder()->setOverridable(TRUE)->save();
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "LBB Introspect Target"]) as $n) { $n->delete(); }
  $node = \Drupal\node\Entity\Node::create(["type" => "article", "title" => "LBB Introspect Target"]);
  $node->save();
  $section = new \Drupal\layout_builder\Section("layout_onecol");
  $comp = new \Drupal\layout_builder\SectionComponent(\Drupal::service("uuid")->generate(), "content", [
    "id" => "system_powered_by_block", "label" => "Powered by", "label_display" => "0", "provider" => "system",
  ]);
  $comp->set("bootstrap_styles", ["block_style" => [
    "background" => ["background_type" => "color"],
    "background_color" => ["class" => "bg-info"],
  ]]);
  $section->appendComponent($comp);
  $node->get("layout_builder__layout")->setValue([$section]);
  $node->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node 'LBB Introspect Target' has a block styled with bg-info"
