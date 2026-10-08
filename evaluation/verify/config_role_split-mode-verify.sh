#!/usr/bin/env bash
# Execution VERIFY: PASS when role_split crs_mode has mode=fork. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("role_split")->load("crs_mode");
  if (!$e) { print "FAIL missing\n"; return; }
  $mode = $e->get("mode");
  print (($mode === "fork") ? "PASS" : "FAIL") . " mode=" . var_export($mode, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
