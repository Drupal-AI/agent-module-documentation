#!/usr/bin/env bash
# Execution VERIFY for memory_limit_policy_http_method: PASS when policy mlp_http_method_exec exists and carries a 'http_method' constraint
# with the expected configuration. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$e = \Drupal::entityTypeManager()->getStorage("memory_limit_policy")->load("mlp_http_method_exec");
$ok = FALSE; $info = "no-constraint";
foreach(($e?$e->getConstraints():[]) as $c){if(($c["id"]??"")==="http_method" && in_array("put",$c["methods"]??[])){$ok=TRUE;$info="methods=".implode(",",$c["methods"]);}}
$ok = ($e && $ok);
print ($ok ? "PASS" : "FAIL") . " policy=" . ($e ? $e->id() : "none") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
