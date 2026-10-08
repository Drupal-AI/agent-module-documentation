#!/usr/bin/env bash
# Execution CLEANUP: ensure the deprecated module is uninstalled (baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu views_dependent_filter -y >/dev/null 2>&1
echo "cleanup: deprecated module views_dependent_filter uninstalled"
