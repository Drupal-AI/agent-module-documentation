#!/usr/bin/env bash
# Execution VERIFY: PASS when a quick_node_block placement renders the QNB Sample node in the
# 'full' view mode. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "QNB Sample"]);
  $node = $nodes ? reset($nodes) : NULL;
  $nid = $node ? $node->id() : "___none___";
  $ok = FALSE;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "quick_node_block") {
      $s = $b->get("settings");
      $qd = $s["quick_display"] ?? "";
      $qn = $s["quick_node"] ?? "";
      if ($qd === "full" && strpos($qn, "(" . $nid . ")") !== FALSE) { $ok = TRUE; break; }
    }
  }
  print $ok ? "PASS" : "FAIL";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
