#!/usr/bin/env bash
# Execution VERIFY (pdf_reader, layman): PASS when field_pdf_doc uses the FieldPdfReaderFields
# formatter in the Article default view display. Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_pdf_doc") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "FieldPdfReaderFields");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
