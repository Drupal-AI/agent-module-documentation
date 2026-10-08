#!/usr/bin/env bash
# Execution VERIFY: PASS when server sao_new exists, uses the opensearch backend, a standard
# connector, and a non-empty cluster URL. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\search_api\Entity\Server;
  $s = Server::load("sao_new");
  if (!$s) { print "FAIL no-server\n"; return; }
  $bc = $s->getBackendConfig();
  $backend = $s->getBackendId();
  $conn = $bc["connector"] ?? "none";
  $url = $bc["connector_config"]["url"] ?? "";
  $ok = ($backend === "opensearch" && $conn === "standard" && $url !== "");
  print ($ok?"PASS":"FAIL")." backend=".$backend." connector=".$conn." url=".$url."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
