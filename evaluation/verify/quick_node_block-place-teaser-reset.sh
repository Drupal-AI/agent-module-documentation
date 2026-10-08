#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\block\Entity\Block;
  if (!\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "QNB Sample Two"])) {
    Node::create(["type" => "article", "title" => "QNB Sample Two"])->save();
  }
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "quick_node_block") {
      $s = $b->get("settings");
      if (isset($s["quick_node"]) && strpos($s["quick_node"], "QNB Sample Two") !== FALSE) { $b->delete(); }
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: QNB Sample Two node present, no quick_node_block referencing it"
