#!/usr/bin/env bash
# Execution VERIFY: PASS when dropsolid_purge.config has site_name 'AcmeProd' and a loadbalancer with
# ip 198.51.100.20 and port 8080. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("dropsolid_purge.config");
  $sn = $c->get("site_name");
  $lbs = $c->get("loadbalancers") ?: [];
  $hit = FALSE;
  foreach ($lbs as $lb) {
    if (($lb["ip"] ?? "") === "198.51.100.20" && (string) ($lb["port"] ?? "") === "8080") { $hit = TRUE; }
  }
  $ok = ($sn === "AcmeProd" && $hit);
  print ($ok ? "PASS" : "FAIL") . " site_name=" . var_export($sn, TRUE) . " lb_match=" . var_export($hit, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
