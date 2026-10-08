#!/usr/bin/env bash
# Execution VERIFY: PASS when entity_update.settings excludes protects taxonomy_term AND
# taxonomy_vocabulary in addition to the shipped user and user_role. A checkboxes form stores
# checked ids as the id itself; unchecked ones as 0 - both are accepted as long as the value is
# truthy. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ex = \Drupal::config("entity_update.settings")->get("excludes") ?: [];
  $need = ["user", "user_role", "taxonomy_term", "taxonomy_vocabulary"];
  $missing = [];
  foreach ($need as $k) { if (empty($ex[$k])) { $missing[] = $k; } }
  $ok = empty($missing);
  print ($ok ? "PASS" : "FAIL") . " excludes=" . implode(",", array_keys(array_filter($ex)))
    . " missing=" . (implode(",", $missing) ?: "-") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
