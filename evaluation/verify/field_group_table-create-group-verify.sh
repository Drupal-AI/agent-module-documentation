#!/usr/bin/env bash
# Execution VERIFY: PASS when the Article default view display has a field group 'group_fgt_task'
# whose format_type is field_group_table. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $g = $d->getThirdPartySetting("field_group","group_fgt_task");
  $ft = is_array($g) ? ($g["format_type"] ?? NULL) : NULL;
  $ok = ($ft === "field_group_table");
  print ($ok ? "PASS" : "FAIL") . " group=" . var_export((bool)$g,TRUE) . " format_type=" . var_export($ft,TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
