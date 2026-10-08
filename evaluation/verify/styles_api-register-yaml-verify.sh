#!/usr/bin/env bash
# Execution VERIFY: PASS when the styles_api plugin manager has a definition 'sap_eval_yaml'
# (registered via a themes.yml YAML declaration).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("plugin.manager.styles_api");
  $ok = $m->hasDefinition("sap_eval_yaml");
  print ($ok ? "PASS" : "FAIL") . " sap_eval_yaml=" . ($ok ? "registered" : "missing") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
