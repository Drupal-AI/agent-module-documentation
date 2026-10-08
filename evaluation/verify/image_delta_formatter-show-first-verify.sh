#!/usr/bin/env bash
# Execution VERIFY: PASS when field_idf_shots in the default view display uses
# image_delta_formatter and its settings.deltas includes 0. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_idf_shots") : NULL;
  $type = $c["type"] ?? "none";
  $deltas = $c["settings"]["deltas"] ?? [];
  if (is_scalar($deltas)) { $deltas = array_map("intval", array_map("trim", explode(",", (string) $deltas))); }
  $ok = ($type === "image_delta_formatter") && in_array(0, (array) $deltas);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " deltas=" . json_encode($deltas) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
