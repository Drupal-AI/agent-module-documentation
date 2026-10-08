#!/usr/bin/env bash
# Execution VERIFY for "render field_pdf_manual with the pdf.js viewer".
# PASS when the field_pdf_manual component of core.entity_view_display.node.article.default
# uses formatter `pdf_default` with keep_pdfjs TRUE, height 800px, initial page 4 and
# zoom page-fit. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_pdf_manual") : NULL;
  $t = $c["type"] ?? "none";
  $s = $c["settings"] ?? [];
  $ok = ($t === "pdf_default")
    && !empty($s["keep_pdfjs"])
    && (($s["height"] ?? "") === "800px")
    && ((string) ($s["page"] ?? "") === "4")
    && (($s["zoom"] ?? "") === "page-fit");
  print ($ok ? "PASS" : "FAIL")
    . " type=" . $t
    . " keep_pdfjs=" . var_export($s["keep_pdfjs"] ?? NULL, TRUE)
    . " height=" . var_export($s["height"] ?? NULL, TRUE)
    . " page=" . var_export($s["page"] ?? NULL, TRUE)
    . " zoom=" . var_export($s["zoom"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
