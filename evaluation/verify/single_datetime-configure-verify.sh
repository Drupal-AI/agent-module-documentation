#!/usr/bin/env bash
# Execution VERIFY: PASS when field_sdt_conf uses the Single DateTimePicker widget AND its
# hour_format setting is 12h. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.single_datetime_eval.default");
  $c = $fd ? $fd->getComponent("field_sdt_conf") : NULL;
  $type = $c["type"] ?? "none";
  $hf = $c["settings"]["hour_format"] ?? "unset";
  $ok = ($type === "single_date_time_widget" && $hf === "12h");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " hour_format=" . $hf . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
