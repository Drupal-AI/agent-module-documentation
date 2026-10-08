#!/usr/bin/env bash
# Execution VERIFY: PASS when the existing ckbsgrid_plain format now has the bootstrapGrid
# toolbar item and its ckeditor_bs_grid_grid plugin config has use_cdn FALSE and cdn_url
# https://example.com/bootstrap-grid.css . Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $e = Editor::load("ckbsgrid_plain");
  $s = $e ? $e->getSettings() : [];
  $items = $s["toolbar"]["items"] ?? [];
  $p = $s["plugins"]["ckeditor_bs_grid_grid"] ?? [];
  $ok = $e
    && in_array("bootstrapGrid", $items, TRUE)
    && array_key_exists("use_cdn", $p) && !$p["use_cdn"]
    && ($p["cdn_url"] ?? NULL) === "https://example.com/bootstrap-grid.css";
  print ($ok ? "PASS" : "FAIL")
    . " toolbar=" . implode(",", $items)
    . " use_cdn=" . var_export($p["use_cdn"] ?? NULL, TRUE)
    . " cdn_url=" . var_export($p["cdn_url"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
