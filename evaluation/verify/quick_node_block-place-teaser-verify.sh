#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "QNB Sample Two"]);
  $node = $nodes ? reset($nodes) : NULL;
  $nid = $node ? $node->id() : "___none___";
  $ok = FALSE;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "quick_node_block") {
      $s = $b->get("settings");
      if (($s["quick_display"] ?? "") === "teaser" && strpos($s["quick_node"] ?? "", "(".$nid.")") !== FALSE) { $ok = TRUE; break; }
    }
  }
  print $ok ? "PASS" : "FAIL";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
