#!/usr/bin/env bash
# Introspection CLEANUP: uninstall the deprecated views_dependent_filter module (baseline is
# disabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu views_dependent_filter -y >/dev/null 2>&1
echo "cleanup: deprecated module views_dependent_filter uninstalled"
