#!/usr/bin/env bash
# Execution VERIFY: PASS only when VAPN is enabled on BOTH 'article' and 'page'
# (vapn.settings bundles.article and bundles.page are truthy). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal::config("vapn.settings")->get("bundles") ?: [];
  $ok = !empty($b["article"]) && !empty($b["page"]);
  print ($ok ? "PASS" : "FAIL") . " bundles=" . json_encode($b) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
