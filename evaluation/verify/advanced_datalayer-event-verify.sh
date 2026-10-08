#!/usr/bin/env bash
# Execution VERIFY: PASS when the node context's 'event' datalayer tag === 'pageview'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("advanced_datalayer_defaults")->load("node");
  $tags = $d ? $d->get("tags") : [];
  $v = $tags["event"] ?? NULL;
  print (($v === "pageview") ? "PASS" : "FAIL") . " event=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
