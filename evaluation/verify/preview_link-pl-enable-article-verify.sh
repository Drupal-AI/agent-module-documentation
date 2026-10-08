#!/usr/bin/env bash
# Execution VERIFY: PASS when the Article bundle is enabled for preview links, i.e.
# enabled_entity_types.node includes 'article' OR is present as an empty list (all bundles).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $types = \Drupal::config("preview_link.settings")->get("enabled_entity_types") ?: [];
  $node = $types["node"] ?? NULL;
  $ok = is_array($node) && (count($node) === 0 || in_array("article", $node, TRUE));
  print ($ok ? "PASS" : "FAIL") . " enabled_entity_types=" . json_encode($types) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
