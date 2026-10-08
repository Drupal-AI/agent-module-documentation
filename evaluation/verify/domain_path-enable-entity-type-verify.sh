#!/usr/bin/env bash
# Execution VERIFY: PASS when domain_path.settings.entity_types contains taxonomy_term. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("domain_path.settings")->get("entity_types") ?: [];
  $ok = in_array("taxonomy_term", $t, TRUE);
  print ($ok ? "PASS" : "FAIL") . " entity_types=" . implode(",", $t) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
