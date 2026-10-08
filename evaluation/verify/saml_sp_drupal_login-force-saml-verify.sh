#!/usr/bin/env bash
# Execution VERIFY: PASS when saml_sp_drupal_login.config force_saml_only is TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("saml_sp_drupal_login.config")->get("force_saml_only");
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ((($ok) ? "PASS" : "FAIL")." force_saml_only=".var_export($v,true)."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
