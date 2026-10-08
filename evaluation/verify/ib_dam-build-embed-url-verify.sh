#!/usr/bin/env bash
# Execution VERIFY: PASS when allow_embedding === true AND login_url === acme.intelligencebank.com.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("ib_dam.settings");
  $emb = $c->get("allow_embedding");
  $url = $c->get("login_url");
  $ok = ((bool) $emb === TRUE && $emb !== NULL && $url === "acme.intelligencebank.com");
  print ($ok ? "PASS" : "FAIL") . " allow_embedding=" . var_export($emb, TRUE) . " login_url=" . var_export($url, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
