#!/usr/bin/env bash
# Live-state verification for "configure the Article body to the expand_collapse_formatter".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Reads core.entity_view_display.node.article.default and checks the `body` component:
#   fmt  — formatter type is expand_collapse_formatter
#   len  — trim_length setting == 150
#   st   — default_state setting == expanded
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fmt = FALSE; $len = FALSE; $st = FALSE; $detail = "";
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) {
    $c = $vd->getComponent("body");
    if (is_array($c)) {
      $type = $c["type"] ?? "";
      $s = $c["settings"] ?? [];
      $fmt = ($type === "expand_collapse_formatter");
      $len = ((int) ($s["trim_length"] ?? 0)) === 150;
      $st  = (($s["default_state"] ?? "") === "expanded");
      $detail = "type=" . $type . " trim_length=" . ($s["trim_length"] ?? "?") . " default_state=" . ($s["default_state"] ?? "?");
    } else {
      $detail = "body component not in content region (hidden)";
    }
  }
  $ok = $fmt && $len && $st;
  print ($ok ? "PASS" : "FAIL") . " fmt=" . ($fmt?1:0) . " len=" . ($len?1:0) . " st=" . ($st?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
