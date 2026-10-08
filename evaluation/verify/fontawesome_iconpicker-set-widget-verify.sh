#!/usr/bin/env bash
# Execution VERIFY: PASS when field_faip_task's default form-display widget is
# fontawesome_iconpicker. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_faip_task") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "fontawesome_iconpicker") ? "PASS" : "FAIL") . " widget=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
