#!/usr/bin/env bash
# Execution VERIFY: PASS when onlyone_task is in onlyone.settings onlyone_node_types.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $types = \Drupal::config("onlyone.settings")->get("onlyone_node_types") ?: [];
  $ok = in_array("onlyone_task", $types, true);
  print ($ok ? "PASS" : "FAIL") . " onlyone_node_types=" . implode(",",$types) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
