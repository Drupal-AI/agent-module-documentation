#!/usr/bin/env bash
# MEDIUM introspection SETUP: ensure entity_hierarchy_workbench_access (and its workbench_access
# dependency) is enabled so an agent can inspect the access-control-hierarchy plugin it adds.
set -uo pipefail
cd /var/www/html
drush en entity_hierarchy_workbench_access -y >/dev/null 2>&1
echo "setup: entity_hierarchy_workbench_access enabled"
