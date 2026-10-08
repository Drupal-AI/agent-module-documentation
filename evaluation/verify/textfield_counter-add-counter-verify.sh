#!/usr/bin/env bash
# Execution VERIFY: PASS when field_tfc_task uses the text_textarea_with_counter widget with a
# maxlength >= 1 (counter active). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_tfc_task") : NULL;
  $type = $c["type"] ?? "none";
  $max = (int) ($c["settings"]["maxlength"] ?? 0);
  $ok = ($type === "text_textarea_with_counter" && $max >= 1);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " maxlength=" . $max . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
