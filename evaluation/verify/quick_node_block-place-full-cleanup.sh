#!/usr/bin/env bash
# Execution CLEANUP: remove any quick_node_block referencing QNB Sample and delete the fixture
# node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "quick_node_block") {
      $s = $b->get("settings");
      if (isset($s["quick_node"]) && strpos($s["quick_node"], "QNB Sample") !== FALSE) { $b->delete(); }
    }
  }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "QNB Sample"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: QNB Sample node and its quick_node_block removed"
