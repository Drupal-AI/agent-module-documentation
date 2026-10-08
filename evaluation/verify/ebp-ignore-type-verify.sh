#!/usr/bin/env bash
# Execution VERIFY: PASS when entity_bundle_permissions.settings:ignored_entity_types contains
# 'taxonomy_term'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $list = \Drupal::config("entity_bundle_permissions.settings")->get("ignored_entity_types") ?: [];
  $ok = in_array("taxonomy_term", $list, TRUE);
  print ($ok ? "PASS" : "FAIL") . " list=" . implode(",", $list) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
