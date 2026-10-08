#!/usr/bin/env bash
# Execution VERIFY: PASS when both content_editor and administrator are delegated/assignable.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $roles = array_values(array_filter(\Drupal::config("roleassign.settings")->get("roleassign_roles") ?? []));
  sort($roles);
  $ok = ($roles === ["administrator","content_editor"]);
  print ($ok ? "PASS" : "FAIL") . " roles=[" . implode(",", $roles) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
