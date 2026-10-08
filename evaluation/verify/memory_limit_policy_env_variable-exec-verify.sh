#!/usr/bin/env bash
# Execution VERIFY for memory_limit_policy_env_variable: PASS when policy mlp_env_variable_exec exists and carries a 'env_variable' constraint
# with the expected configuration. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$e = \Drupal::entityTypeManager()->getStorage("memory_limit_policy")->load("mlp_env_variable_exec");
$ok = FALSE; $info = "no-constraint";
foreach(($e?$e->getConstraints():[]) as $c){if(($c["id"]??"")==="env_variable" && ($c["name"]??"")==="APP_ENV"){$ok=TRUE;$info="name=".$c["name"]." values=".implode(",",$c["values"]??[]);}}
$ok = ($e && $ok);
print ($ok ? "PASS" : "FAIL") . " policy=" . ($e ? $e->id() : "none") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
