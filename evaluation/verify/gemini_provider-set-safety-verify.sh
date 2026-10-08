#!/usr/bin/env bash
# Execution VERIFY: PASS when safety_settings sets HARM_CATEGORY_HATE_SPEECH to the requested
# threshold BLOCK_MEDIUM_AND_ABOVE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::config("gemini_provider.settings")->get("safety_settings") ?: [];
  $v = $s["HARM_CATEGORY_HATE_SPEECH"] ?? NULL;
  print (($v === "BLOCK_MEDIUM_AND_ABOVE") ? "PASS" : "FAIL") . " hate_speech=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
