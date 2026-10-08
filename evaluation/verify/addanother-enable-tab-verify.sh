#!/usr/bin/env bash
# Execution VERIFY: PASS when addanother.settings tab.blog_post === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("addanother.settings")->get("tab.blog_post");
  print (($v === TRUE) ? "PASS" : "FAIL") . " tab.blog_post=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
