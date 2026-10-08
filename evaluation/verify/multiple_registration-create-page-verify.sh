#!/usr/bin/env bash
# Execution VERIFY: PASS when create_registration_page_form_config has an mr_task entry whose path
# references 'signup-task'. Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("multiple_registration.create_registration_page_form_config")->get("mr_task");
  $path = is_array($c) ? (string) ($c["path"] ?? "") : "";
  $url = is_array($c) ? (string) ($c["url"] ?? "") : "";
  $ok = is_array($c) && (strpos($path, "signup-task") !== FALSE);
  print (($ok) ? "PASS" : "FAIL") . " path=" . var_export($path, TRUE) . " url=" . var_export($url, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
