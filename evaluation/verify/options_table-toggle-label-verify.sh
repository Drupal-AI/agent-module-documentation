#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ot_label's options_table widget has settings.toggle_label
# === 'Selected'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_ot_label") : NULL;
  $type = $c["type"] ?? "none";
  $label = $c["settings"]["toggle_label"] ?? NULL;
  $ok = ($type === "options_table" && $label === "Selected");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " toggle_label=" . var_export($label, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
