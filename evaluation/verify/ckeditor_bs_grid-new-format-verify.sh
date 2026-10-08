#!/usr/bin/env bash
# Execution VERIFY: PASS when a text format ckbsgrid_task exists, uses CKEditor 5, has the
# bootstrapGrid toolbar item, and its ckeditor_bs_grid_grid plugin configuration allows exactly
# columns 1-4 and exactly the xs and lg breakpoints. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  $f = FilterFormat::load("ckbsgrid_task");
  $e = Editor::load("ckbsgrid_task");
  $s = $e ? $e->getSettings() : [];
  $items = $s["toolbar"]["items"] ?? [];
  $p = $s["plugins"]["ckeditor_bs_grid_grid"] ?? [];
  $cols = array_values(array_map("strval", array_filter((array) ($p["available_columns"] ?? []))));
  sort($cols);
  $bps = array_values(array_map("strval", array_filter((array) ($p["available_breakpoints"] ?? []))));
  sort($bps);
  $ok = $f && $e && $e->getEditor() === "ckeditor5"
    && in_array("bootstrapGrid", $items, TRUE)
    && $cols === ["1", "2", "3", "4"]
    && $bps === ["lg", "xs"];
  print ($ok ? "PASS" : "FAIL")
    . " format=" . ($f ? "yes" : "no")
    . " editor=" . ($e ? $e->getEditor() : "none")
    . " toolbar=" . implode(",", $items)
    . " columns=" . implode(",", $cols)
    . " breakpoints=" . implode(",", $bps) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
