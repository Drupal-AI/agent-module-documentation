#!/usr/bin/env bash
# Execution VERIFY: PASS when Gutenberg is enabled for the gutenberg_task content type, i.e.
# gutenberg.settings:gutenberg_task_enable_full is truthy. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("gutenberg.settings")->get("gutenberg_task_enable_full");
  print ((bool) $v ? "PASS" : "FAIL") . " gutenberg_task_enable_full=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
