#!/usr/bin/env bash
# Execution VERIFY: PASS when simple_block sblb_a exists and is placed as a component in node.sblb_h1.default.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\simple_block\Entity\SimpleBlock;
  if (!SimpleBlock::load("sblb_a")) { print "FAIL simple_block sblb_a missing\n"; return; }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.sblb_h1.default");
  if (!$vd || !$vd->isLayoutBuilderEnabled()) { print "FAIL Layout Builder not enabled on node.sblb_h1.default\n"; return; }
  $found = FALSE;
  foreach ($vd->getSections() as $sec) {
    foreach ($sec->getComponents() as $c) {
      if ($c->getPluginId() === "simple_block:sblb_a") { $found = TRUE; }
    }
  }
  print ($found ? "PASS" : "FAIL") . " component simple_block:sblb_a " . ($found ? "placed" : "absent") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
