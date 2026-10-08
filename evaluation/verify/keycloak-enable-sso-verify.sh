#!/usr/bin/env bash
# Execution VERIFY: PASS when the kc_sso Keycloak client has BOTH keycloak_sso === TRUE and
# keycloak_sign_out === TRUE in its settings. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("openid_connect_client")->load("kc_sso");
  $set = $e ? ($e->get("settings") ?: []) : [];
  $sso = !empty($set["keycloak_sso"]);
  $out = !empty($set["keycloak_sign_out"]);
  $ok = ($e && $sso && $out);
  print ($ok ? "PASS" : "FAIL") . " sso=" . var_export($sso, TRUE) . " sign_out=" . var_export($out, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
