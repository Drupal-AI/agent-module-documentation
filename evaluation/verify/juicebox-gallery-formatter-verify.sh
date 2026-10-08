#!/usr/bin/env bash
# Live-state verification for "configure the Article gallery field to the Juicebox formatter".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Reads core.entity_view_display.node.article.default and checks the field_jb_gallery component:
#   fmt  — formatter type is juicebox_formatter
#   img  — image_style setting == juicebox_medium
#   th   — thumb_style setting == juicebox_square_thumb
# NOTE: a rendered gallery also needs the Juicebox JS library under /libraries/juicebox/,
# but that is out of scope here — this verifies the config-level formatter setup only.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fmt = FALSE; $img = FALSE; $th = FALSE; $detail = "";
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) {
    $c = $vd->getComponent("field_jb_gallery");
    if (is_array($c)) {
      $type = $c["type"] ?? "";
      $s = $c["settings"] ?? [];
      $fmt = ($type === "juicebox_formatter");
      $img = (($s["image_style"] ?? "") === "juicebox_medium");
      $th  = (($s["thumb_style"] ?? "") === "juicebox_square_thumb");
      $detail = "type=" . $type . " image_style=" . ($s["image_style"] ?? "?") . " thumb_style=" . ($s["thumb_style"] ?? "?");
    } else {
      $detail = "field_jb_gallery not in content region (hidden/missing)";
    }
  } else {
    $detail = "node.article.default display missing";
  }
  $ok = $fmt && $img && $th;
  print ($ok ? "PASS" : "FAIL") . " fmt=" . ($fmt?1:0) . " img=" . ($img?1:0) . " th=" . ($th?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
