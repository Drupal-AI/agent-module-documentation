#!/usr/bin/env bash
# Execution VERIFY: PASS when multiple_registration_disable_main == 1. Read-only. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("multiple_registration.common_settings_page_form_config")->get("multiple_registration_disable_main");
  print (((int) $v === 1) ? "PASS" : "FAIL") . " multiple_registration_disable_main=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
