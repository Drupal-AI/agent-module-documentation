#!/usr/bin/env bash
# Execution VERIFY: PASS when Markdownify is restricted to ONLY the 'article' node bundle, i.e.
# supported_entities.node.bundles.default === FALSE and 'article' is in the selected list.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal::config("markdownify.settings")->get("supported_entities.node.bundles");
  $default = $b["default"] ?? NULL;
  $selected = $b["selected"] ?? [];
  $ok = ($default === FALSE && in_array("article", (array) $selected, TRUE));
  print (($ok) ? "PASS" : "FAIL") . " default=" . var_export($default, TRUE) . " selected=" . implode(",", (array) $selected) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
