#!/usr/bin/env bash
# Execution CLEANUP: ensure twig_tools is enabled again (documented baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install twig_tools -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: twig_tools enabled (baseline restored)"
