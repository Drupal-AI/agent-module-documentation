#!/usr/bin/env bash
# Execution VERIFY: PASS when VAPN is enabled on the 'article' bundle (vapn.settings
# bundles.article is truthy). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal::config("vapn.settings")->get("bundles") ?: [];
  $ok = !empty($b["article"]);
  print ($ok ? "PASS" : "FAIL") . " bundles=" . json_encode($b) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
