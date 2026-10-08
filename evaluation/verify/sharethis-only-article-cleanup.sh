#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default node_types {article, page}.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("sharethis.settings")->set("node_types",["article"=>"article","page"=>"page"])->save();' >/dev/null 2>&1
echo "cleanup: sharethis.settings node_types restored to {article, page}"
