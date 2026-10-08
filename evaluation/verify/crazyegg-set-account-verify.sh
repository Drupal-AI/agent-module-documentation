#!/usr/bin/env bash
# Execution VERIFY: PASS when crazyegg_account_id == 1234567 and crazyegg_js_scope == footer.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("crazyegg.settings");
  $id = (string) $c->get("crazyegg_account_id");
  $scope = (string) $c->get("crazyegg_js_scope");
  $ok = ($id === "1234567" && $scope === "footer");
  print ($ok ? "PASS" : "FAIL") . " account_id=$id js_scope=$scope\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
