#!/usr/bin/env bash
# Execution VERIFY: PASS when the menu_entity_index table has a row whose target is the
# node titled 'MEI Hard Target' and whose menu_name is 'main' (i.e. the agent created and
# indexed a main-menu link referencing that node). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "MEI Hard Target"]);
  $node = $nodes ? reset($nodes) : NULL;
  $count = 0;
  if ($node) {
    $count = (int) \Drupal::database()->select("menu_entity_index", "m")
      ->condition("target_type", "node")
      ->condition("target_id", $node->id())
      ->condition("menu_name", "main")
      ->countQuery()->execute()->fetchField();
  }
  print (($count > 0) ? "PASS" : "FAIL") . " nid=" . ($node ? $node->id() : "none") . " rows=" . $count . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
