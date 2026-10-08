#!/usr/bin/env bash
# Introspection SETUP: enable the deprecated views_dependent_filter (singular) module so an
# inspecting agent can detect it via drush pm:list. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en views_dependent_filter -y >/dev/null 2>&1
echo "setup: deprecated module views_dependent_filter enabled"
