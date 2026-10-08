#!/usr/bin/env bash
# Execution VERIFY: PASS when the gutenberg_lock content type's template lock is set to 'all'
# in gutenberg.settings. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("gutenberg.settings")->get("gutenberg_lock_template_lock");
  print (($v === "all") ? "PASS" : "FAIL") . " gutenberg_lock_template_lock=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
