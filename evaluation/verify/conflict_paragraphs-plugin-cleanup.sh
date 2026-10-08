#!/usr/bin/env bash
# Introspection CLEANUP: leave conflict_paragraphs enabled (its enabled state is the documented baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install conflict_paragraphs -y >/dev/null 2>&1
echo "cleanup: conflict_paragraphs left enabled (baseline)"
