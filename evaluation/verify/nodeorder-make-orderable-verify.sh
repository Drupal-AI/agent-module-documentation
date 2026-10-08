#!/usr/bin/env bash
# Execution VERIFY: PASS when nodeorder_hard is orderable (truthy entry in
# nodeorder.settings.vocabularies). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = \Drupal::service("nodeorder.manager")->vocabularyIsOrderable("nodeorder_hard");
  $map = \Drupal::config("nodeorder.settings")->get("vocabularies");
  print ($ok ? "PASS" : "FAIL") . " entry=" . var_export($map["nodeorder_hard"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
