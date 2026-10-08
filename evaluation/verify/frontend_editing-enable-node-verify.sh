#!/usr/bin/env bash
# Execution VERIFY: PASS when the Article node bundle is enabled for frontend editing, i.e.
# frontend_editing.settings entity_types.node contains "article". Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::config("frontend_editing.settings")->get("entity_types") ?: [];
  $node = $e["node"] ?? [];
  $ok = is_array($node) && in_array("article", $node, TRUE);
  print ($ok ? "PASS" : "FAIL") . " node_bundles=" . json_encode(array_values($node)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
