#!/usr/bin/env bash
# Execution VERIFY: PASS when field_tfc_limit's counter widget has maxlength == 100.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_tfc_limit") : NULL;
  $type = $c["type"] ?? "none";
  $max = (int) ($c["settings"]["maxlength"] ?? 0);
  $ok = ($type === "string_textfield_with_counter" && $max === 100);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " maxlength=" . $max . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
