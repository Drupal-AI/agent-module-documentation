#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default toc_type template ('responsive').
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("toc_api.toc_type.default")->set("options.template", "responsive")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: default toc_type template restored to 'responsive'"
