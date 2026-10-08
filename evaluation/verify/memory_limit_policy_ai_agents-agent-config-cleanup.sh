#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default max_loops (5) on memory_limit_policy_agent.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$a = \Drupal::entityTypeManager()->getStorage("ai_agent")->load("memory_limit_policy_agent");
if ($a) { $a->set("max_loops", 5)->save(); }
' >/dev/null 2>&1
echo "cleanup: ai_agent memory_limit_policy_agent max_loops restored to 5"
