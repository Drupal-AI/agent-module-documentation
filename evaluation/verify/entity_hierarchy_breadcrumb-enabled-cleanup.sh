#!/usr/bin/env bash
# MEDIUM CLEANUP: leave the submodule enabled (baseline for this campaign). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en entity_hierarchy_breadcrumb -y >/dev/null 2>&1
echo "cleanup: entity_hierarchy_breadcrumb enabled (baseline)"
