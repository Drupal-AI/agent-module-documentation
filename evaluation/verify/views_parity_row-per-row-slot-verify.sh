#!/usr/bin/env bash
# Execution VERIFY: PASS when views_parity_row_demo default row is the parity plugin with per-row
# enabled and view_mode_1 == 'full'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("views_parity_row_demo");
  $row = $v ? ($v->get("display")["default"]["display_options"]["row"] ?? []) : [];
  $type = $row["type"] ?? "none";
  $o = $row["options"] ?? [];
  $en = !empty($o["views_parity_row_per_row_enable"]);
  $vm1 = $o["views_parity_row_per_row"]["view_mode_1"] ?? NULL;
  $ok = ($type === "views_parity_row_entity:node") && $en && ($vm1 === "full");
  print ($ok ? "PASS" : "FAIL") . " type=$type perrow=" . var_export($en, TRUE) . " view_mode_1=" . var_export($vm1, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
