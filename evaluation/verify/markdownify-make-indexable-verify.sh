#!/usr/bin/env bash
# Execution VERIFY: PASS when markdownify.settings noindex === FALSE (agent made Markdown
# responses indexable). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("markdownify.settings")->get("noindex");
  print (($v === FALSE) ? "PASS" : "FAIL") . " noindex=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
