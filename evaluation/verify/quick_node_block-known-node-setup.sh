#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\block\Entity\Block;
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "QNB Featured Item"]);
  $node = $nodes ? reset($nodes) : Node::create(["type" => "article", "title" => "QNB Featured Item"]);
  if ($node->isNew()) { $node->save(); }
  if ($b = Block::load("qnb_known_node_block")) { $b->delete(); }
  Block::create([
    "id" => "qnb_known_node_block", "plugin" => "quick_node_block",
    "theme" => \Drupal::config("system.theme")->get("default"),
    "region" => "content", "weight" => -9,
    "settings" => ["id"=>"quick_node_block","label"=>"Featured","label_display"=>"0","quick_node"=>"QNB Featured Item (".$node->id().")","quick_display"=>"full"],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: qnb_known_node_block renders 'QNB Featured Item'"
