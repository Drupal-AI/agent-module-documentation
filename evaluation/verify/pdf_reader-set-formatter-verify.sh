#!/usr/bin/env bash
# Execution VERIFY (pdf_reader): PASS when the field_pdf_task component in the Article default
# view display uses the FieldPdfReaderFields formatter. Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_pdf_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "FieldPdfReaderFields");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
