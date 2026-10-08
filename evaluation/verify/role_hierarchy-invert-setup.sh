#!/usr/bin/env bash
# Introspection SETUP: enable the inverted hierarchy in role_hierarchy.settings so the agent
# must read the config to say which direction roles can edit. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("role_hierarchy.settings")
    ->set("invert", TRUE)->set("strict", FALSE)
    ->set("non_hierarchical_roles", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role_hierarchy.settings invert=TRUE"
