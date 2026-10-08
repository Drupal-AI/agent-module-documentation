#!/usr/bin/env bash
# Execution VERIFY: PASS when field_dtf_time widget is datetime_flatpickr with settings.enableTime===TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_dtf_time") : NULL;
  $t = $c["settings"]["enableTime"] ?? NULL;
  $ok = ($c["type"] ?? "") === "datetime_flatpickr" && ($t === TRUE || $t === 1 || $t === "1");
  print ($ok ? "PASS" : "FAIL") . " type=" . ($c["type"] ?? "none") . " enableTime=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
