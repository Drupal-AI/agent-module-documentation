#!/usr/bin/env bash
# Execution RESET: seed a domain-scoped pathauto-state key-value entry for domain dpp_task
# (collection domain_path_pathauto_state.dpp_task.node), so verify FAILS until the agent purges
# it. Idempotent (overwrites). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::keyValue("domain_path_pathauto_state.dpp_task.node")->set("dpp_seed", 1);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: seeded domain_path_pathauto_state.dpp_task.node"
