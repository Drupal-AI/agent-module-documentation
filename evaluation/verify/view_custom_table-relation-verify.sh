#!/usr/bin/env bash
# Execution VERIFY (view_custom_table): PASS when vct_rel is registered with its uid column related to
# the user entity, so the module adds a Views relationship on vct_rel.uid whose base is the user data
# table (users_field_data). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::service("views.views_data")->clear();
  $d = \Drupal::service("views.views_data")->get("vct_rel");
  $rel = $d["uid"]["relationship"] ?? NULL;
  $base = $rel["base"] ?? "";
  $ok = is_array($rel) && ($base === "users_field_data" || $base === "users");
  print ($ok ? "PASS" : "FAIL") . " uid_relationship=" . var_export(is_array($rel), TRUE) . " base=" . $base . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
