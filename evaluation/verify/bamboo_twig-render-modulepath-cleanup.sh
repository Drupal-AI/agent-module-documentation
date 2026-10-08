#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
rm -f web/sites/default/files/bamboo_parent_modulepath.html.twig
echo "cleanup: removed bamboo_parent_modulepath.html.twig"
