#!/usr/bin/env bash
# Execution VERIFY: PASS when Key ee_api_key exists, uses the easy_encrypted provider, and decrypts
# to 'super-secret-token'. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $k = \Drupal::service("key.repository")->getKey("ee_api_key");
  if (!$k) { print "FAIL no-key\n"; return; }
  $provider = $k->getKeyProvider()->getPluginId();
  $val = $k->getKeyValue();
  $ok = ($provider === "easy_encrypted") && ($val === "super-secret-token");
  print ($ok ? "PASS" : "FAIL") . " provider=" . $provider . " decrypts_ok=" . var_export($val === "super-secret-token", TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
