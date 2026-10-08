#!/usr/bin/env bash
# Execution VERIFY: PASS when field_svgf_task in core.entity_view_display.node.article.default
# uses the svg_formatter formatter with inline output on, sanitizing on, and dimensions 48x48.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_svgf_task") : NULL;
  $t = $c["type"] ?? "none";
  $s = $c["settings"] ?? [];
  $ok = ($t === "svg_formatter")
    && !empty($s["inline"]) && !empty($s["sanitize"]) && !empty($s["apply_dimensions"])
    && (int) ($s["width"] ?? 0) === 48 && (int) ($s["height"] ?? 0) === 48;
  print ($ok ? "PASS" : "FAIL") . " type=" . $t
    . " inline=" . var_export($s["inline"] ?? NULL, TRUE)
    . " sanitize=" . var_export($s["sanitize"] ?? NULL, TRUE)
    . " w=" . var_export($s["width"] ?? NULL, TRUE)
    . " h=" . var_export($s["height"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
