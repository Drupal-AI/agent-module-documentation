#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ms_off is NOT in multiple_select.settings node-article list
# (agent disabled the helper for it) while the field still exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $exists = (bool) FieldConfig::loadByName("node","article","field_ms_off");
  $t = \Drupal::config("multiple_select.settings")->get("table");
  $d = $t ? json_decode($t, TRUE) : [];
  $list = $d["node-article"] ?? [];
  $ok = $exists && !in_array("field_ms_off", (array) $list, TRUE);
  print ($ok ? "PASS" : "FAIL") . " field_exists=" . var_export($exists, TRUE) . " table=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
