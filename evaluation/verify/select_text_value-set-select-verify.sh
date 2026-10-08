#!/usr/bin/env bash
# Execution VERIFY: PASS when field_stv_task on the stv_content default form display uses the
# select_string_textfield widget as a dropdown (select_type=select) with allowed values
# containing Red, Green and Blue. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "stv_content", "default");
  $c = $fd ? $fd->getComponent("field_stv_task") : NULL;
  $type = $c["type"] ?? "none";
  $st = $c["settings"]["select_type"] ?? "";
  $av = $c["settings"]["allowed_values"] ?? "";
  $hasvals = (stripos($av, "Red") !== FALSE && stripos($av, "Green") !== FALSE && stripos($av, "Blue") !== FALSE);
  $ok = ($type === "select_string_textfield" && $st === "select" && $hasvals);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " select_type=" . $st . " hasvals=" . var_export($hasvals, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
