#!/usr/bin/env bash
# Execution VERIFY for memory_limit_policy_drush: PASS when policy mlp_drush_exec exists and carries a 'drush' constraint
# with the expected configuration. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$e = \Drupal::entityTypeManager()->getStorage("memory_limit_policy")->load("mlp_drush_exec");
$ok = FALSE; $info = "no-constraint";
foreach(($e?$e->getConstraints():[]) as $c){if(($c["id"]??"")==="drush" && str_contains($c["drush_commands"]??"","migrate:import")){$ok=TRUE;$info="drush_commands=".$c["drush_commands"];}}
$ok = ($e && $ok);
print ($ok ? "PASS" : "FAIL") . " policy=" . ($e ? $e->id() : "none") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
