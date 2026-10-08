#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $type = \Drupal::config("field.storage.user.field_sfa_new")->get("type");
  $w = \Drupal::config("core.entity_form_display.user.user.default")->get("content.field_sfa_new.type");
  $ok = ($type === "address" && $w === "salesforce_ready_address");
  print (($ok) ? "PASS" : "FAIL") . " field_type=" . var_export($type, TRUE) . " widget=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
