#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled node.article.ief_table view display exists with at least
# one visible field component (a column). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.ief_table");
  if (!$vd) { print "FAIL no-display\n"; return; }
  $enabled = $vd->status();
  $cols = 0;
  foreach (array_keys($vd->getComponents()) as $name) {
    $c = $vd->getComponent($name);
    if (!empty($c["type"])) { $cols++; }
  }
  $ok = $enabled && $cols >= 1;
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " columns=" . $cols . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
