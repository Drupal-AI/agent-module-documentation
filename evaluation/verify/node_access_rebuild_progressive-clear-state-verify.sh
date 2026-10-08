#!/usr/bin/env bash
# Execution VERIFY: PASS when the progressive-rebuild state is clean:
# .current == 0 (idle) AND .bundles is empty/unset. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cur = \Drupal::state()->get("node_access_rebuild_progressive.current", 0);
  $bundles = \Drupal::state()->get("node_access_rebuild_progressive.bundles", []);
  $ok = ((int) $cur === 0 && empty($bundles));
  print ($ok ? "PASS" : "FAIL") . " current=" . var_export($cur, TRUE) . " bundles=" . json_encode($bundles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
