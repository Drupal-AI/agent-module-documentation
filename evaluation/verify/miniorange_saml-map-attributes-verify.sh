#!/usr/bin/env bash
# Execution VERIFY: PASS when email attr=EmailAddress and username attr=Username. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("miniorange_saml.settings");
  $e = (string) $c->get("miniorange_saml_email_attribute");
  $u = (string) $c->get("miniorange_saml_username_attribute");
  $ok = ($e === "EmailAddress") && ($u === "Username");
  print ($ok ? "PASS" : "FAIL") . " email_attr=[$e] username_attr=[$u]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
