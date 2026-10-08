#!/usr/bin/env bash
# Execution VERIFY for "configure key_auth to use param_name 'api-token' with only the
# header detection method enabled". PASS when key_auth.settings has param_name === 'api-token'
# AND detection_methods === ['header'] exactly (no 'query'). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("key_auth.settings");
  $param_name = $config->get("param_name");
  $methods = $config->get("detection_methods") ?: [];
  sort($methods);
  $ok = ($param_name === "api-token") && ($methods === ["header"]);
  print ($ok ? "PASS" : "FAIL") . " param_name=" . var_export($param_name, TRUE) . " detection_methods=" . json_encode($methods) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
