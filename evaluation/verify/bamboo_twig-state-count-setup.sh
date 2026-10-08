#!/usr/bin/env bash
# Introspection SETUP: seed a known numeric State value for read-back via Bamboo Twig.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("bamboo_parent_count",4242);' >/dev/null 2>&1
echo "setup: state bamboo_parent_count=4242"
