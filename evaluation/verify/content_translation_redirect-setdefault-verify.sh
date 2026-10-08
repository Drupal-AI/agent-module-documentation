#!/usr/bin/env bash
# Execution VERIFY: PASS when the Default redirect's status code is 302.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::entityTypeManager()->getStorage("content_translation_redirect")->load("default");
  $code = $r ? $r->getStatusCode() : NULL;
  $ok = ($code === 302);
  print ($ok ? "PASS" : "FAIL") . " default_code=" . var_export($code,true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
