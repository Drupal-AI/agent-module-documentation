#!/usr/bin/env bash
# Execution VERIFY: PASS when the default view display of node.bif_task2 uses the
# background_image_formatter on field_bif_link with output type 'inline' and
# background_image_link === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.bif_task2.default");
  $c = $vd ? $vd->getComponent("field_bif_link") : NULL;
  $type = $c["type"] ?? "none";
  $ot = $c["settings"]["background_image_output_type"] ?? NULL;
  $ln = $c["settings"]["background_image_link"] ?? NULL;
  $isTrue = ($ln === TRUE || $ln === 1 || $ln === "1");
  $ok = ($type === "background_image_formatter" && $ot === "inline" && $isTrue);
  print ($ok ? "PASS" : "FAIL") . " type=$type output=" . var_export($ot, TRUE) . " link=" . var_export($ln, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
