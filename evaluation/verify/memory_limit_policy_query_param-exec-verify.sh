#!/usr/bin/env bash
# Execution VERIFY for memory_limit_policy_query_param: PASS when policy mlp_query_param_exec exists and carries a 'query_param' constraint
# with the expected configuration. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$e = \Drupal::entityTypeManager()->getStorage("memory_limit_policy")->load("mlp_query_param_exec");
$ok = FALSE; $info = "no-constraint";
foreach(($e?$e->getConstraints():[]) as $c){if(($c["id"]??"")==="query_param" && str_contains($c["query_param"]??"","export")){$ok=TRUE;$info="query_param=".$c["query_param"];}}
$ok = ($e && $ok);
print ($ok ? "PASS" : "FAIL") . " policy=" . ($e ? $e->id() : "none") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
