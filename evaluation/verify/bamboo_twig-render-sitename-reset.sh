#!/usr/bin/env bash
# Execution RESET: remove the agent's answer template so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
rm -f web/sites/default/files/bamboo_parent_sitename.html.twig
echo "reset: removed bamboo_parent_sitename.html.twig"
