#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
rm -f web/sites/default/files/bamboo_twig_file_render_url.html.twig
echo "cleanup: removed bamboo_twig_file_render_url.html.twig"
