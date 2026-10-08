#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a file field field_svgf_build whose allowed
# extensions include svg AND whose component in core.entity_view_display.node.article.default
# uses the svg_formatter formatter. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_svgf_build");
  $type = $fc ? $fc->getType() : "none";
  $ext = $fc ? (string) $fc->getSetting("file_extensions") : "";
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_svgf_build") : NULL;
  $fmt = $c["type"] ?? "none";
  $ok = ($type === "file") && (stripos($ext, "svg") !== FALSE) && ($fmt === "svg_formatter");
  print ($ok ? "PASS" : "FAIL") . " field_type=" . $type . " extensions=\"" . $ext . "\" formatter=" . $fmt . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
