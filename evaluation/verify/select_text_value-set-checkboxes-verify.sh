#!/usr/bin/env bash
# Execution VERIFY: PASS when field_stv_multi on the stv_content default form display uses the
# select_string_textfield widget with select_type=checkboxes and a non-empty allowed_values.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "stv_content", "default");
  $c = $fd ? $fd->getComponent("field_stv_multi") : NULL;
  $type = $c["type"] ?? "none";
  $st = $c["settings"]["select_type"] ?? "";
  $av = trim($c["settings"]["allowed_values"] ?? "");
  $ok = ($type === "select_string_textfield" && $st === "checkboxes" && $av !== "");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " select_type=" . $st . " av_len=" . strlen($av) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
