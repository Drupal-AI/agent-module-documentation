#!/usr/bin/env bash
# Execution VERIFY: PASS when all three IdP details match the requested values. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("miniorange_saml.settings");
  $n = (string) $c->get("miniorange_saml_idp_name");
  $i = (string) $c->get("miniorange_saml_idp_issuer");
  $u = (string) $c->get("miniorange_saml_idp_login_url");
  $ok = ($n === "Corp IdP") && ($i === "https://idp.corp-h1.example.com/entity") && ($u === "https://idp.corp-h1.example.com/sso");
  print ($ok ? "PASS" : "FAIL") . " name=[$n] issuer=[$i] login_url=[$u]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
