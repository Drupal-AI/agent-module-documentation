#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
rm -f web/sites/default/files/bamboo_twig_file_render_ext.html.twig
echo "reset: removed bamboo_twig_file_render_ext.html.twig"
