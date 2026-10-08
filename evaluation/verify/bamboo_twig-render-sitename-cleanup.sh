#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
rm -f web/sites/default/files/bamboo_parent_sitename.html.twig
echo "cleanup: removed bamboo_parent_sitename.html.twig"
