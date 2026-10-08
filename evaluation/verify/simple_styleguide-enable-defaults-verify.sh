#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'blockquote' and 'table' built-in default patterns are enabled
# (truthy) in simple_styleguide.styleguidesettings.default_patterns. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $dp = \Drupal::config("simple_styleguide.styleguidesettings")->get("default_patterns") ?: [];
  $bq = !empty($dp["blockquote"]);
  $tb = !empty($dp["table"]);
  $ok = $bq && $tb;
  print ($ok ? "PASS" : "FAIL") . " blockquote=" . var_export($dp["blockquote"] ?? NULL,TRUE) . " table=" . var_export($dp["table"] ?? NULL,TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
