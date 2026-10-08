#!/usr/bin/env bash
# HARD live-state verification for "configure the slick_entityreference formatter using the
# eval_hard_set optionset". PASS (exit 0) iff node.article default display renders
# field_ser_hard2 with the slick_entityreference_vanilla formatter AND its optionset setting
# is eval_hard_set. Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  error_reporting(E_ERROR);
  $c = \Drupal::service("entity_display.repository")
    ->getViewDisplay("node","article","default")
    ->getComponent("field_ser_hard2");
  $type = $c["type"] ?? "";
  $os = $c["settings"]["optionset"] ?? "";
  $ok = ($type === "slick_entityreference_vanilla" && $os === "eval_hard_set");
  print ($ok ? "PASS" : "FAIL") . " type=" . ($type ?: "none") . " optionset=" . ($os ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
