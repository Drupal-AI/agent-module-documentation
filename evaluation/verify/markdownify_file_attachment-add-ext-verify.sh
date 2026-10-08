#!/usr/bin/env bash
# Execution VERIFY: PASS when 'csv' is in allowed_extensions (agent enabled inline embedding of
# .csv attachments) AND the pre-existing types are still present. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::config("markdownify_file_attachment.settings")->get("allowed_extensions") ?: [];
  $ok = in_array("csv", $e, TRUE) && in_array("txt", $e, TRUE);
  print (($ok) ? "PASS" : "FAIL") . " exts=" . implode(",", $e) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
