#!/usr/bin/env bash
# Execution VERIFY: PASS when lagoon_logs.settings host=collector.example.net and port=5544.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("lagoon_logs.settings");
  $ok = ($c->get("host") === "collector.example.net") && ((int) $c->get("port") === 5544);
  print ($ok ? "PASS" : "FAIL")." host=".$c->get("host")." port=".$c->get("port")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
