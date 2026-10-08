#!/usr/bin/env bash
# Execution VERIFY: PASS when index_revisions is truthy AND node is indexed.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("taxonomy_entity_index.settings");
  $rev = $cfg->get("index_revisions");
  $t = $cfg->get("types") ?: [];
  $ok = (!empty($rev) && in_array("node", array_values($t), TRUE));
  print ($ok ? "PASS" : "FAIL") . " index_revisions=" . var_export($rev, TRUE) . " types=" . implode(",", array_values($t)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
