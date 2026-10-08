#!/usr/bin/env bash
# Execution VERIFY: PASS when the breadcrumb extra field is enabled for node/page in config
# (breadcrumb_extra_field_admin.node.page is truthy) AND the extra display field is exposed on
# node.page. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $admin = \Drupal::config("breadcrumb_extra_field.settings")->get("breadcrumb_extra_field_admin") ?: [];
  $cfg = !empty($admin["node"]["page"]);
  $extra = \Drupal::service("entity_field.manager")->getExtraFields("node","page");
  $field = isset($extra["display"]["breadcrumb"]);
  $ok = ($cfg && $field);
  print (($ok) ? "PASS" : "FAIL") . " config=" . var_export($admin["node"]["page"] ?? NULL, TRUE) . " extra_field=" . var_export($field, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
