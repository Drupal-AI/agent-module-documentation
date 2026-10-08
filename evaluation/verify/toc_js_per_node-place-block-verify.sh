#!/usr/bin/env bash
# Execution VERIFY: PASS when a block using the toc_js_per_node_block plugin is placed. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $blocks = \Drupal::entityTypeManager()->getStorage("block")->loadByProperties(["plugin"=>"toc_js_per_node_block"]);
  $ids = [];
  foreach ($blocks as $b) { $ids[] = $b->id(); }
  print (count($ids) ? "PASS" : "FAIL") . " blocks=" . implode(",", $ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
