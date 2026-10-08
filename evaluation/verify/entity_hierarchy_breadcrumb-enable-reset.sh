#!/usr/bin/env bash
# HARD execution RESET: uninstall entity_hierarchy_breadcrumb so hierarchy breadcrumbs are OFF
# and verify FAILs until the agent enables it. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu entity_hierarchy_breadcrumb -y >/dev/null 2>&1
echo "reset: entity_hierarchy_breadcrumb uninstalled"
