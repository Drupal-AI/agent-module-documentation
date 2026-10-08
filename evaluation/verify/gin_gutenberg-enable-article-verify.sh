#!/usr/bin/env bash
# Execution VERIFY: PASS when gutenberg.settings:article_enable_full === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("gutenberg.settings")->get("article_enable_full");
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " article_enable_full=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
