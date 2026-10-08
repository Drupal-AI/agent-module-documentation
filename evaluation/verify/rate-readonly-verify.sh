#!/usr/bin/env bash
# Execution VERIFY: PASS when rate_widget 'rate_ro' has display.readonly truthy (1), i.e. the
# agent set it read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::entityTypeManager()->getStorage("rate_widget")->load("rate_ro");
  $display = $w ? (array) $w->get("display") : [];
  $ro = $display["readonly"] ?? NULL;
  $ok = $w && ((int) $ro === 1);
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool) $w, TRUE) . " readonly=" . var_export($ro, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
