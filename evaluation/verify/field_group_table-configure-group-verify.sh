#!/usr/bin/env bash
# Execution VERIFY: PASS when group_fgt_cfg is a field_group_table group whose format_settings set
# first_column='Field' and table_row_striping truthy. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $g = $d->getThirdPartySetting("field_group","group_fgt_cfg");
  $ft = is_array($g) ? ($g["format_type"] ?? NULL) : NULL;
  $fs = is_array($g) ? ($g["format_settings"] ?? []) : [];
  $ok = ($ft === "field_group_table") && (($fs["first_column"] ?? NULL) === "Field") && !empty($fs["table_row_striping"]);
  print ($ok ? "PASS" : "FAIL") . " format_type=" . var_export($ft,TRUE) . " first_column=" . var_export($fs["first_column"] ?? NULL,TRUE) . " striping=" . var_export($fs["table_row_striping"] ?? NULL,TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
