#!/usr/bin/env bash
# Live-state verification for "configure node.article field_eval_recur_w to use the Alpha
# modular widget". Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# Checks the entity_form_display component widget id for the field is date_recur_modular_alpha.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::service("entity_display.repository")
    ->getFormDisplay("node", "article", "default")
    ->getComponent("field_eval_recur_w");
  $type = is_array($c) ? ($c["type"] ?? "") : "";
  $ok = ($type === "date_recur_modular_alpha");
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($type === "" ? "(none)" : $type) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
