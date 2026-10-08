#!/usr/bin/env bash
# Execution VERIFY: PASS when queue_mail_keys targets the user_password_reset mail id
# (exact id, or a wildcard like user_* that would match it) WITHOUT queuing everything ('*').
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("queue_mail.settings")->get("queue_mail_keys");
  $lines = array_filter(array_map("trim", preg_split("/\r?\n/", $v)));
  $matches = FALSE;
  foreach ($lines as $line) {
    if ($line === "*") { continue; }
    if (\Drupal::service("path.matcher")->matchPath("user_password_reset", $line)) { $matches = TRUE; }
  }
  print ($matches ? "PASS" : "FAIL") . " queue_mail_keys=" . json_encode($lines) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
