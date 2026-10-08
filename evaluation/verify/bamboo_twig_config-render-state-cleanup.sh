#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("bamboo_config_target");' >/dev/null 2>&1
rm -f web/sites/default/files/bamboo_twig_config_render_state.html.twig
echo "cleanup: state bamboo_config_target deleted, template removed"
