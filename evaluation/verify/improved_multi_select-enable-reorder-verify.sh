#!/usr/bin/env bash
# Execution VERIFY: PASS when orderable===TRUE and buttontext_add==='ADD'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("improved_multi_select.settings");
  $ok = ($c->get("orderable") === TRUE) && ($c->get("buttontext_add") === "ADD");
  print ($ok ? "PASS" : "FAIL") . " orderable=" . var_export($c->get("orderable"), TRUE) . " add=" . var_export($c->get("buttontext_add"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
