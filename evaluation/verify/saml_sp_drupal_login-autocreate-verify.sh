#!/usr/bin/env bash
# Execution VERIFY: PASS when account_request_create_account is TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("saml_sp_drupal_login.config")->get("account_request_create_account");
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ((($ok) ? "PASS" : "FAIL")." account_request_create_account=".var_export($v,true)."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
