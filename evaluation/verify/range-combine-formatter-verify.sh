#!/usr/bin/env bash
# Execution VERIFY for "display field_range_fee with the Unformatted range formatter".
# PASS when the field_range_fee component of core.entity_view_display.node.article.default uses
# the range_unformatted formatter with range_separator ' to ', range_combine TRUE and
# combined_prefix_suffix TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_range_fee") : NULL;
  $type = $c["type"] ?? "none";
  $s = $c["settings"] ?? [];
  $sep = $s["range_separator"] ?? NULL;
  $combine = $s["range_combine"] ?? NULL;
  $cps = $s["combined_prefix_suffix"] ?? NULL;
  $ok = $type === "range_unformatted" && $sep === " to " && (bool) $combine === TRUE && (bool) $cps === TRUE;
  print ($ok ? "PASS" : "FAIL")
    . " formatter=" . $type
    . " range_separator=" . var_export($sep, TRUE)
    . " range_combine=" . var_export($combine, TRUE)
    . " combined_prefix_suffix=" . var_export($cps, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
