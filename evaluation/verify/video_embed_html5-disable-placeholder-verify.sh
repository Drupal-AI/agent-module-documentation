#!/usr/bin/env bash
# Execution VERIFY: PASS when video_embed_html5.config add_placeholder === false.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("video_embed_html5.config")->get("add_placeholder");
  print (($v === FALSE || $v === 0 || $v === "0") ? "PASS" : "FAIL") . " add_placeholder=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
