#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush en entity_hierarchy_breadcrumb -y >/dev/null 2>&1
echo "cleanup: entity_hierarchy_breadcrumb enabled (baseline)"
