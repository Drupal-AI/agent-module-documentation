#!/usr/bin/env bash
# Execution VERIFY: PASS when a block using the toc_js_block plugin is placed (id tocjs_testblock or
# any enabled block with that plugin). Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $blocks = \Drupal::entityTypeManager()->getStorage("block")->loadByProperties(["plugin"=>"toc_js_block"]);
  $ok = FALSE; $ids = [];
  foreach ($blocks as $b) { $ids[] = $b->id(); $ok = TRUE; }
  print ($ok ? "PASS" : "FAIL") . " blocks=" . implode(",", $ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
