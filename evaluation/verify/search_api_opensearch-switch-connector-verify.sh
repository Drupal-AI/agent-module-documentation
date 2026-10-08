#!/usr/bin/env bash
# Execution VERIFY: PASS when server sao_switch's opensearch backend uses the 'basicauth'
# connector. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\search_api\Entity\Server;
  $s = Server::load("sao_switch");
  if (!$s) { print "FAIL no-server\n"; return; }
  $conn = $s->getBackendConfig()["connector"] ?? "none";
  $ok = ($s->getBackendId() === "opensearch" && $conn === "basicauth");
  print ($ok?"PASS":"FAIL")." connector=".$conn."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
