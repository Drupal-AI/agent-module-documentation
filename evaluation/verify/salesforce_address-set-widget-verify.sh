#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("core.entity_form_display.user.user.default")->get("content.field_sfa_task.type");
  print (($t === "salesforce_ready_address") ? "PASS" : "FAIL") . " widget=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
