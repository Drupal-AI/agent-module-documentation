#!/usr/bin/env bash
# Execution VERIFY: PASS when remote_url is set to the required endpoint. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $u = (string) \Drupal::config("site_audit_send.settings")->get("remote_url");
  $ok = ($u === "https://sas-task.example.com/api/site-audit");
  print ($ok ? "PASS" : "FAIL") . " remote_url=[" . $u . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
