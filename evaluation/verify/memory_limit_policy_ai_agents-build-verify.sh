#!/usr/bin/env bash
# Execution VERIFY: PASS when mlp_ai_exec exists with memory 640M and status enabled — the end
# state the ai_agent 'create_memory_limit_policy' tool produces. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$e = \Drupal::entityTypeManager()->getStorage("memory_limit_policy")->load("mlp_ai_exec");
$ok = ($e && $e->getMemory() === "640M" && $e->status() === TRUE);
print ($ok ? "PASS" : "FAIL") . " policy=" . ($e ? $e->id() : "none") . " mem=" . ($e ? $e->getMemory() : "-") . " status=" . ($e ? var_export($e->status(), TRUE) : "-") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
