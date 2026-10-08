#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "quick_node_block") {
      $s = $b->get("settings");
      if (isset($s["quick_node"]) && strpos($s["quick_node"], "QNB Sample Two") !== FALSE) { $b->delete(); }
    }
  }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "QNB Sample Two"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: QNB Sample Two node and its block removed"
