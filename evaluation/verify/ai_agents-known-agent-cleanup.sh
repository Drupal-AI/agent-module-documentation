#!/usr/bin/env bash
# Introspection CLEANUP for the ai_agents "known agent" medium cases.
# Restores baseline by deleting the eval_known_agent config entity created by
# ai_agents-known-agent-setup.sh. Idempotent: a no-op if it is already gone.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("ai_agent")->load("eval_known_agent")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ai_agent 'eval_known_agent' deleted (baseline restored)"
