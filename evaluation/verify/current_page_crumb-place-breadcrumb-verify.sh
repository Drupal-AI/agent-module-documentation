#!/usr/bin/env bash
# Execution VERIFY for "place a Breadcrumb block in the Canvas Stark theme so current_page_crumb
# crumbs render". PASS when at least one ENABLED system_breadcrumb_block exists in canvas_stark.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n = 0; $where = "";
  foreach (\Drupal::entityTypeManager()->getStorage("block")
      ->loadByProperties(["plugin" => "system_breadcrumb_block", "theme" => "canvas_stark"]) as $b) {
    if ($b->status()) { $n++; $where .= $b->id() . "@" . $b->getRegion() . " "; }
  }
  print (($n > 0) ? "PASS" : "FAIL") . " enabled_breadcrumb_blocks_in_canvas_stark=" . $n . " " . trim($where) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
