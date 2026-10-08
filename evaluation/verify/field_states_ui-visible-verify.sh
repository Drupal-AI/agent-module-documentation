#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fsui_task's widget has a field_states_ui state with id 'visible'
# whose data.target is field_fsui_trigger.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_fsui_task") : NULL;
  $states = $c["third_party_settings"]["field_states_ui"]["field_states"] ?? [];
  $ok = FALSE; $found = "none";
  foreach ($states as $s) {
    $found = ($s["id"] ?? "?") . "/" . ($s["data"]["target"] ?? "?");
    if (($s["id"] ?? NULL) === "visible" && ($s["data"]["target"] ?? NULL) === "field_fsui_trigger") { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " states_count=" . count($states) . " sample=" . $found . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
