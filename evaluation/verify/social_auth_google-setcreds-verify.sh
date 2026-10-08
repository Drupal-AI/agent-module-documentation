#!/usr/bin/env bash
# Execution VERIFY: PASS when client_id and client_secret are set to the expected values. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("social_auth_google.settings");
  $id = $c->get("client_id"); $sec = $c->get("client_secret");
  $ok = ($id === "eval-set.apps.googleusercontent.com" && $sec === "eval-secret-xyz");
  print ($ok ? "PASS" : "FAIL") . " client_id=" . var_export($id, TRUE) . " secret_set=" . var_export($sec !== "" && $sec !== NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
