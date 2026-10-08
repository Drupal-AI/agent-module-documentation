#!/usr/bin/env bash
# Execution VERIFY: PASS when views_parity_row_demo default row is the parity plugin with cadence
# enabled, alternate view_mode 'full' and frequency '2'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("views_parity_row_demo");
  $row = $v ? ($v->get("display")["default"]["display_options"]["row"] ?? []) : [];
  $type = $row["type"] ?? "none";
  $o = $row["options"] ?? [];
  $en = !empty($o["views_parity_row_enable"]);
  $vm = $o["views_parity_row"]["view_mode"] ?? NULL;
  $fq = (string) ($o["views_parity_row"]["frequency"] ?? "");
  $ok = ($type === "views_parity_row_entity:node") && $en && ($vm === "full") && ($fq === "2");
  print ($ok ? "PASS" : "FAIL") . " type=$type enable=" . var_export($en, TRUE) . " altmode=" . var_export($vm, TRUE) . " freq=$fq\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
