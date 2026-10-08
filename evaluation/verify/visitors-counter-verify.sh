#!/usr/bin/env bash
# Execution VERIFY: PASS when visitors.config counter.entity_types contains 'user'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("visitors.config")->get("counter.entity_types");
  $ok = is_array($t) && in_array("user", $t, TRUE);
  print ($ok ? "PASS" : "FAIL")." entity_types=".implode(",", is_array($t)?$t:[])."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
