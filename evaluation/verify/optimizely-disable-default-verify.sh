#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'default' sitewide project is DISABLED (state FALSE), so its
# snippet no longer loads sitewide. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("optimizely")->load("default");
  $state = $p ? $p->getState() : NULL;
  $ok = ($p && !$state);
  print ($ok ? "PASS" : "FAIL") . " default_state=" . var_export($state, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
