#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("bamboo_config_target","FERRET-42");' >/dev/null 2>&1
rm -f web/sites/default/files/bamboo_twig_config_render_state.html.twig
echo "reset: state bamboo_config_target=FERRET-42, template removed"
