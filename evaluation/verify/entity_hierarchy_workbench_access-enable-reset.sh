#!/usr/bin/env bash
# HARD execution RESET: uninstall entity_hierarchy_workbench_access so the Workbench Access
# integration is OFF and verify FAILs until the agent enables it. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu entity_hierarchy_workbench_access -y >/dev/null 2>&1
echo "reset: entity_hierarchy_workbench_access uninstalled"
