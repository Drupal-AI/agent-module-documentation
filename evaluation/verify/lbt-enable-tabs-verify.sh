#!/usr/bin/env bash
# Execution VERIFY: PASS when node.lbt_demo default view display has Layout Builder ENABLED and a
# section with layout id 'tabs'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.lbt_demo.default");
  $lb = $d && $d->isLayoutBuilderEnabled();
  $tabs = FALSE;
  if ($lb) { foreach ($d->getSections() as $sec) { if ($sec->getLayoutId() === "tabs") { $tabs = TRUE; } } }
  $ok = $lb && $tabs;
  print ($ok ? "PASS" : "FAIL") . " lb=" . var_export($lb, TRUE) . " tabs=" . var_export($tabs, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
