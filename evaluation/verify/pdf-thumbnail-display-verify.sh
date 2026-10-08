#!/usr/bin/env bash
# Execution VERIFY for "show only the first page of field_pdf_preview as a thumbnail".
# PASS when the field_pdf_preview component of core.entity_view_display.node.article.teaser
# uses formatter `pdf_thumbnail` with scale 2 and width 300px.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.teaser");
  $c = $vd ? $vd->getComponent("field_pdf_preview") : NULL;
  $t = $c["type"] ?? "none";
  $s = $c["settings"] ?? [];
  $ok = ($t === "pdf_thumbnail")
    && ((string) ($s["scale"] ?? "") === "2")
    && (($s["width"] ?? "") === "300px");
  print ($ok ? "PASS" : "FAIL")
    . " type=" . $t
    . " scale=" . var_export($s["scale"] ?? NULL, TRUE)
    . " width=" . var_export($s["width"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
