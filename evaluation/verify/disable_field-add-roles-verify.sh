#!/usr/bin/env bash
# Execution VERIFY (disable_field, add/roles): PASS when field_df_task on Article disables the
# field on the ADD form for the content_editor role (add_disable === "roles" AND add_roles
# contains content_editor). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_df_task");
  $mode = $fc ? $fc->getThirdPartySetting("disable_field","add_disable") : NULL;
  $roles = $fc ? ($fc->getThirdPartySetting("disable_field","add_roles") ?: []) : [];
  $ok = ($mode === "roles" && is_array($roles) && in_array("content_editor", $roles));
  print ($ok ? "PASS" : "FAIL") . " add_disable=" . var_export($mode, TRUE) . " roles=" . implode(",", (array) $roles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
