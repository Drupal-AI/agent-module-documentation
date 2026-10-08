#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ti_head in core.entity_view_display.node.article.default
# uses the textimage_text_field_formatter. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $c = $vd ? $vd->getComponent("field_ti_head") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "textimage_text_field_formatter");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
