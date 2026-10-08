#!/usr/bin/env bash
# Execution RESET: ensure role_hierarchy.settings exists with strict=FALSE (so verify FAILS
# until the agent enables strict mode). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("role_hierarchy.settings")
    ->set("strict", FALSE)->set("invert", FALSE)
    ->set("non_hierarchical_roles", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role_hierarchy.settings strict=FALSE"
