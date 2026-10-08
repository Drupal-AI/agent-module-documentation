#!/usr/bin/env bash
# Execution RESET: ensure a fixture article 'QNB Sample' exists and remove any leftover task
# block so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\block\Entity\Block;
  if (!\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "QNB Sample"])) {
    Node::create(["type" => "article", "title" => "QNB Sample"])->save();
  }
  // Remove any quick_node_block placement referencing QNB Sample so the state is clean.
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "quick_node_block") {
      $s = $b->get("settings");
      if (isset($s["quick_node"]) && strpos($s["quick_node"], "QNB Sample") !== FALSE) { $b->delete(); }
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: QNB Sample node present, no quick_node_block referencing it"
