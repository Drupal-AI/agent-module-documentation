#!/usr/bin/env bash
# Execution RESET: seed domain-scoped pathauto-state for domain dpp_task2 across TWO entity-type
# collections (node + taxonomy_term), so verify FAILS until the agent purges ALL of the domain's
# pathauto state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::keyValue("domain_path_pathauto_state.dpp_task2.node")->set("s1", 1);
  \Drupal::keyValue("domain_path_pathauto_state.dpp_task2.taxonomy_term")->set("s2", 1);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: seeded dpp_task2 pathauto state (node + taxonomy_term)"
