#!/usr/bin/env bash
# Execution VERIFY: PASS when field_isbn_fmt display formatter is isbn_formatted_formatter.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $c = $vd->getComponent("field_isbn_fmt");
  $type = $c["type"] ?? "none";
  $ok = ($type === "isbn_formatted_formatter");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
