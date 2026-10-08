#!/usr/bin/env bash
# Execution VERIFY: PASS when field_faip_display's default view-display formatter is
# fontawesome_iconpicker_formatter_type with size fa-2x. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_faip_display") : NULL;
  $t = $c["type"] ?? "none";
  $s = $c["settings"]["size"] ?? "none";
  $ok = ($t === "fontawesome_iconpicker_formatter_type" && $s === "fa-2x");
  print (($ok) ? "PASS" : "FAIL") . " formatter=" . $t . " size=" . $s . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
