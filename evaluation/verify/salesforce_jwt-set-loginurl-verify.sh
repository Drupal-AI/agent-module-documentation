#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $a = \Drupal::entityTypeManager()->getStorage("salesforce_auth")->load("sfj_ltask");
  $u = $a ? ($a->get("provider_settings")["login_url"] ?? NULL) : NULL;
  print (($u === "https://login.salesforce.com") ? "PASS" : "FAIL") . " login_url=" . var_export($u, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
