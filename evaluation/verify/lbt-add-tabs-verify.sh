#!/usr/bin/env bash
# Execution VERIFY: PASS when node.lbt_demo default view display has a Layout Builder section whose
# layout id is 'tabs'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.lbt_demo.default");
  $ok = FALSE; $ids = [];
  if ($d && $d->isLayoutBuilderEnabled()) {
    foreach ($d->getSections() as $sec) { $ids[] = $sec->getLayoutId(); if ($sec->getLayoutId() === "tabs") { $ok = TRUE; } }
  }
  print ($ok ? "PASS" : "FAIL") . " layouts=" . implode(",", $ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
