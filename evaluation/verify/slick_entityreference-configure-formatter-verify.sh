#!/usr/bin/env bash
# HARD live-state verification for the "configure the slick_entityreference formatter" task.
# PASS (exit 0) iff the node.article default view display renders field_ser_hard with the
# slick_entityreference_vanilla formatter. Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  error_reporting(E_ERROR);
  $c = \Drupal::service("entity_display.repository")
    ->getViewDisplay("node","article","default")
    ->getComponent("field_ser_hard");
  $type = $c["type"] ?? "";
  $os = $c["settings"]["optionset"] ?? "";
  $ok = ($type === "slick_entityreference_vanilla");
  print ($ok ? "PASS" : "FAIL") . " type=" . ($type ?: "none") . " optionset=" . ($os ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
