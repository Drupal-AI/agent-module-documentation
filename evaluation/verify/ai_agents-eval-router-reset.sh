#!/usr/bin/env bash
# Reset state for the ai_agents "build eval_router" hard/execution case so each run
# starts clean: delete the eval_router ai_agent config entity if a previous run created
# it. Scoped to eval_router only, so any default or other agents are left untouched.
# Idempotent: a no-op if eval_router does not exist.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("ai_agent")->load("eval_router")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ai_agent 'eval_router' deleted"
