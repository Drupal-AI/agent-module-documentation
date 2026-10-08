#!/usr/bin/env bash
# Execution VERIFY (disable_field, edit/all): PASS when field_df_task on Article is configured
# to disable the field on the EDIT form for all users (edit_disable === "all"). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_df_task");
  $v = $fc ? $fc->getThirdPartySetting("disable_field","edit_disable") : NULL;
  $ok = ($v === "all");
  print ($ok ? "PASS" : "FAIL") . " edit_disable=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
