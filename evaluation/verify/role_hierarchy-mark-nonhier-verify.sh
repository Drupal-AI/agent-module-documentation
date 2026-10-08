#!/usr/bin/env bash
# Execution VERIFY: PASS when role_hierarchy.settings non_hierarchical_roles marks rh_bypass as
# excluded from the hierarchy (truthy value under key rh_bypass). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $nh = \Drupal::config("role_hierarchy.settings")->get("non_hierarchical_roles") ?: [];
  $ok = !empty($nh["rh_bypass"]);
  print ($ok ? "PASS" : "FAIL") . " rh_bypass=" . var_export($nh["rh_bypass"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
