#!/usr/bin/env bash
# Execution VERIFY for memory_limit_policy_path: PASS when policy mlp_path_exec exists and carries a 'path' constraint
# with the expected configuration. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$e = \Drupal::entityTypeManager()->getStorage("memory_limit_policy")->load("mlp_path_exec");
$ok = FALSE; $info = "no-constraint";
foreach(($e?$e->getConstraints():[]) as $c){if(($c["id"]??"")==="path" && str_contains($c["paths"]??"","/node")){$ok=TRUE;$info="paths=".$c["paths"];}}
$ok = ($e && $ok);
print ($ok ? "PASS" : "FAIL") . " policy=" . ($e ? $e->id() : "none") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
