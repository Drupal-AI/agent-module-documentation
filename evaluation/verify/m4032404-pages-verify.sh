#!/usr/bin/env bash
# Execution VERIFY: PASS when /secret/* is an INCLUDE redirect list, i.e. pages contains /secret/*
# AND negate === false.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("m4032404.settings");
  $pages = $c->get("pages") ?: [];
  $negate = $c->get("negate");
  $ok = in_array("/secret/*", $pages, TRUE) && ($negate === FALSE);
  print ($ok ? "PASS" : "FAIL") . " pages=" . json_encode($pages) . " negate=" . var_export($negate, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
