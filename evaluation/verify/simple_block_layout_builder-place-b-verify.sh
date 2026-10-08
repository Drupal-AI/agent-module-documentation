#!/usr/bin/env bash
# Execution VERIFY: PASS when simple_block sblb_b exists and is placed as a component in node.sblb_h2.default.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\simple_block\Entity\SimpleBlock;
  if (!SimpleBlock::load("sblb_b")) { print "FAIL simple_block sblb_b missing\n"; return; }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.sblb_h2.default");
  if (!$vd || !$vd->isLayoutBuilderEnabled()) { print "FAIL Layout Builder not enabled on node.sblb_h2.default\n"; return; }
  $found = FALSE;
  foreach ($vd->getSections() as $sec) {
    foreach ($sec->getComponents() as $c) {
      if ($c->getPluginId() === "simple_block:sblb_b") { $found = TRUE; }
    }
  }
  print ($found ? "PASS" : "FAIL") . " component simple_block:sblb_b " . ($found ? "placed" : "absent") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
