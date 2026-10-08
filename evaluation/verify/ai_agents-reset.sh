#!/usr/bin/env bash
# Reset the ai_agents state between eval runs: delete every ai_agent config entity so
# each condition starts from a clean slate. The module ships no default agents, so any
# agent present was created by the run under test.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("ai_agent")->loadMultiple() as $a) { $a->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all ai_agent config entities deleted"
