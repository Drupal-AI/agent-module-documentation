#!/usr/bin/env bash
# Execution VERIFY: PASS when the snowball_stemmer processor on index ss_exc has a stemming
# exception mapping "acme" => "acme". exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ex = \Drupal::config("search_api.index.ss_exc")->get("processor_settings.snowball_stemmer.exceptions") ?? [];
  $ok = isset($ex["acme"]) && $ex["acme"] === "acme";
  print ($ok ? "PASS" : "FAIL") . " exceptions=" . json_encode($ex) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
