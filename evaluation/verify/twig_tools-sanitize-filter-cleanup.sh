#!/usr/bin/env bash
# Introspection CLEANUP: leave twig_tools enabled (documented baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install twig_tools -y >/dev/null 2>&1
echo "cleanup: twig_tools left enabled (baseline)"
