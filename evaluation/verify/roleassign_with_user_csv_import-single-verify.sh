#!/usr/bin/env bash
# Execution VERIFY: PASS when content_editor is the ONLY delegated/assignable role in
# roleassign.settings (what the submodule uses to filter the import form).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $roles = array_values(array_filter(\Drupal::config("roleassign.settings")->get("roleassign_roles") ?? []));
  sort($roles);
  $ok = ($roles === ["content_editor"]);
  print ($ok ? "PASS" : "FAIL") . " roles=[" . implode(",", $roles) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
