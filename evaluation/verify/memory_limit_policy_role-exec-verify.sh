#!/usr/bin/env bash
# Execution VERIFY for memory_limit_policy_role: PASS when policy mlp_role_exec exists and carries a 'role' constraint
# with the expected configuration. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$e = \Drupal::entityTypeManager()->getStorage("memory_limit_policy")->load("mlp_role_exec");
$ok = FALSE; $info = "no-constraint";
foreach(($e?$e->getConstraints():[]) as $c){if(($c["id"]??"")==="role" && array_key_exists("authenticated",$c["roles"]??[])){$ok=TRUE;$info="roles=".implode(",",array_keys($c["roles"]));}}
$ok = ($e && $ok);
print ($ok ? "PASS" : "FAIL") . " policy=" . ($e ? $e->id() : "none") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
