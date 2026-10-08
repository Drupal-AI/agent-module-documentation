#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fsui_req's widget has a field_states_ui state with id 'required'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_fsui_req") : NULL;
  $states = $c["third_party_settings"]["field_states_ui"]["field_states"] ?? [];
  $ok = FALSE;
  foreach ($states as $s) { if (($s["id"] ?? NULL) === "required") { $ok = TRUE; } }
  print ($ok ? "PASS" : "FAIL") . " states_count=" . count($states) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
