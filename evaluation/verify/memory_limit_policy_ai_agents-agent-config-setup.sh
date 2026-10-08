#!/usr/bin/env bash
# Introspection SETUP: set a known sentinel max_loops (9) on the shipped ai_agent config entity
# memory_limit_policy_agent so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$a = \Drupal::entityTypeManager()->getStorage("ai_agent")->load("memory_limit_policy_agent");
if ($a) { $a->set("max_loops", 9)->save(); }
' >/dev/null 2>&1
echo "setup: ai_agent memory_limit_policy_agent max_loops=9"
