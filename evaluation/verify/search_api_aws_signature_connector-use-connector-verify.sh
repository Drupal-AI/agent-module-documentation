#!/usr/bin/env bash
# Execution VERIFY: PASS when server saws_task's opensearch backend uses the aws_signature
# connector. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\search_api\Entity\Server;
  $s = Server::load("saws_task");
  if (!$s) { print "FAIL no-server\n"; return; }
  $conn = $s->getBackendConfig()["connector"] ?? "none";
  $ok = ($s->getBackendId() === "opensearch" && $conn === "aws_signature");
  print ($ok?"PASS":"FAIL")." connector=".$conn."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
