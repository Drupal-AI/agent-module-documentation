#!/usr/bin/env bash
# Execution VERIFY: PASS when ai_provider_azure.settings:data === 'azure-eastus-gpt4o'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("ai_provider_azure.settings")->get("data");
  $ok = ($v === "azure-eastus-gpt4o");
  print ($ok ? "PASS" : "FAIL") . " data=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
