#!/usr/bin/env bash
# Execution VERIFY: PASS when Key ee_conf_secret exists, was secured to the easy_encrypted provider
# (NOT config), and decrypts to 'plainsecret'. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $k = \Drupal::service("key.repository")->getKey("ee_conf_secret");
  if (!$k) { print "FAIL no-key\n"; return; }
  $provider = $k->getKeyProvider()->getPluginId();
  $val = $k->getKeyValue();
  $ok = ($provider === "easy_encrypted") && ($val === "plainsecret");
  print ($ok ? "PASS" : "FAIL") . " provider=" . $provider . " decrypts_ok=" . var_export($val === "plainsecret", TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
