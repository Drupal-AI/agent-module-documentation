#!/usr/bin/env bash
# Execution VERIFY: PASS when the default view display of node.bif_task uses the
# background_image_formatter on field_bif_task with output type 'css' and selector '.bif-hero'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.bif_task.default");
  $c = $vd ? $vd->getComponent("field_bif_task") : NULL;
  $type = $c["type"] ?? "none";
  $ot = $c["settings"]["background_image_output_type"] ?? NULL;
  $sel = $c["settings"]["background_image_selector"] ?? NULL;
  $ok = ($type === "background_image_formatter" && $ot === "css" && $sel === ".bif-hero");
  print ($ok ? "PASS" : "FAIL") . " type=$type output=" . var_export($ot, TRUE) . " selector=" . var_export($sel, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
