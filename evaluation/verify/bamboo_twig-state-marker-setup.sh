#!/usr/bin/env bash
# Introspection SETUP: seed a known State value that Bamboo Twig (bamboo_state_get) can read back.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("bamboo_parent_marker","PANDA-7731");' >/dev/null 2>&1
echo "setup: state bamboo_parent_marker=PANDA-7731"
