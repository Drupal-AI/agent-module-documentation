#!/usr/bin/env bash
# Execution VERIFY: PASS when general.varnish_server == expected and general.varnish_purger truthy.
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("adv_varnish.cache_settings");
  $s = $c->get("general.varnish_server");
  $p = $c->get("general.varnish_purger");
  $ok = ($s === "http://varnish.example.com:6081") && ($p === TRUE || $p === 1 || $p === "1");
  print ($ok ? "PASS" : "FAIL") . " server=" . var_export($s, TRUE) . " purger=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
