#!/usr/bin/env bash
# Execution VERIFY for memory_limit_policy_http_header: PASS when policy mlp_http_header_exec exists and carries a 'http_header' constraint
# with the expected configuration. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$e = \Drupal::entityTypeManager()->getStorage("memory_limit_policy")->load("mlp_http_header_exec");
$ok = FALSE; $info = "no-constraint";
foreach(($e?$e->getConstraints():[]) as $c){if(($c["id"]??"")==="http_header" && ($c["header_name"]??"")==="X-Api-Client"){$ok=TRUE;$info="header=".$c["header_name"]." mode=".($c["match_mode"]??"");}}
$ok = ($e && $ok);
print ($ok ? "PASS" : "FAIL") . " policy=" . ($e ? $e->id() : "none") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
