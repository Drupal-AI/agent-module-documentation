#!/usr/bin/env bash
# Execution VERIFY: PASS when the "article" content type is configured to require a revision
# log message (its machine name is present in content_types). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $types = \Drupal::config("require_revision_log_message.adminsettings")->get("content_types") ?? [];
  $ok = in_array("article", $types, TRUE) || array_key_exists("article", $types);
  print ($ok ? "PASS" : "FAIL") . " content_types=" . json_encode($types) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
