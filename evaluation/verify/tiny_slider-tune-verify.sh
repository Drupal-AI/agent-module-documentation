#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ts_tune tiny_slider formatter has items == 4 AND autoplay truthy.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ts_tune") : NULL;
  $s = $c["settings"] ?? [];
  $items = (int) ($s["items"] ?? 0);
  $ap = !empty($s["autoplay"]);
  $isTs = (($c["type"] ?? "") === "tiny_slider_field_formatter");
  $ok = ($isTs && $items === 4 && $ap);
  print ($ok ? "PASS" : "FAIL") . " type=" . ($c["type"] ?? "none") . " items=" . $items . " autoplay=" . var_export($ap, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
