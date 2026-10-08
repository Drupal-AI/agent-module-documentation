#!/usr/bin/env bash
# Introspection SETUP: create a fixture article 'QNB Known' and place a Quick Node Block
# (qnb_known_block) rendering it in the 'teaser' view mode, so an agent can read back the
# configured display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\block\Entity\Block;
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "QNB Known"]);
  $node = $nodes ? reset($nodes) : Node::create(["type" => "article", "title" => "QNB Known"]);
  if ($node->isNew()) { $node->save(); }
  $nid = $node->id();
  if ($b = Block::load("qnb_known_block")) { $b->delete(); }
  Block::create([
    "id" => "qnb_known_block", "plugin" => "quick_node_block",
    "theme" => \Drupal::config("system.theme")->get("default"),
    "region" => "content", "weight" => -10,
    "settings" => [
      "id" => "quick_node_block", "label" => "QNB Known", "label_display" => "0",
      "quick_node" => "QNB Known (" . $nid . ")", "quick_display" => "teaser",
    ],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: qnb_known_block placed with quick_display=teaser"
