#!/usr/bin/env bash
# Execution VERIFY: PASS when the whitelist is enabled AND cdn.example.org is an allowed host.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("imagecache_external.settings");
  $on = ($c->get("imagecache_external_use_whitelist") == TRUE);
  $hosts = (string) $c->get("imagecache_external_hosts");
  $has = in_array("cdn.example.org", preg_split("/\s+/", $hosts, -1, PREG_SPLIT_NO_EMPTY));
  $ok = ($on && $has);
  print ($ok ? "PASS" : "FAIL") . " whitelist=" . var_export($c->get("imagecache_external_use_whitelist"), TRUE) . " hosts=" . var_export($hosts, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
