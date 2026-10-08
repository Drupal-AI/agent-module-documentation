#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
rm -f web/sites/default/files/bamboo_twig_config_render_sitename.html.twig
echo "reset: removed bamboo_twig_config_render_sitename.html.twig"
