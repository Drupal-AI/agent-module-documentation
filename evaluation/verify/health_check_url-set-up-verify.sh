#!/usr/bin/env bash
# Execution VERIFY (health_check_url, layman): PASS when the endpoint path is /up and the
# response string is Alive with type=string. Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("health_check_url.settings");
  $e = $c->get("endpoint"); $s = $c->get("string"); $t = $c->get("type");
  $ok = ($e === "/up" && $s === "Alive" && $t === "string");
  print ($ok ? "PASS" : "FAIL") . " endpoint=" . var_export($e, TRUE) . " string=" . var_export($s, TRUE) . " type=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
