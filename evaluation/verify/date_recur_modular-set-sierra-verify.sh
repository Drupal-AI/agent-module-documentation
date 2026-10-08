#!/usr/bin/env bash
# Live-state verification for "configure node.article field_eval_recur_s to use the Sierra
# modular widget". Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# Checks the entity_form_display component widget id for the field is date_recur_modular_sierra.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::service("entity_display.repository")
    ->getFormDisplay("node", "article", "default")
    ->getComponent("field_eval_recur_s");
  $type = is_array($c) ? ($c["type"] ?? "") : "";
  $ok = ($type === "date_recur_modular_sierra");
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($type === "" ? "(none)" : $type) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
