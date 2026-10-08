#!/usr/bin/env bash
# Execution VERIFY (health_check_url): PASS when settings are endpoint=/healthz, string=HCU-OK,
# type=string. Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("health_check_url.settings");
  $e = $c->get("endpoint"); $s = $c->get("string"); $t = $c->get("type");
  $ok = ($e === "/healthz" && $s === "HCU-OK" && $t === "string");
  print ($ok ? "PASS" : "FAIL") . " endpoint=" . var_export($e, TRUE) . " string=" . var_export($s, TRUE) . " type=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
