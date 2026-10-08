#!/usr/bin/env bash
# Execution VERIFY: PASS when field_oel_strat uses lazyload_oembed with settings.strategy=onclick.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_oel_strat") : NULL;
  $t = $c["type"] ?? "none";
  $s = $c["settings"]["strategy"] ?? "none";
  $ok = ($t === "lazyload_oembed" && $s === "onclick");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $t . " strategy=" . $s . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
