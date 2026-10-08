#!/usr/bin/env bash
# Execution VERIFY: PASS when ckeditor_media_embed.settings embed_provider is exactly the
# Noembed template. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $want = "//noembed.com/embed?url={url}&callback={callback}";
  $got = \Drupal::config("ckeditor_media_embed.settings")->get("embed_provider");
  print (($got === $want) ? "PASS" : "FAIL") . " provider=" . var_export($got, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
