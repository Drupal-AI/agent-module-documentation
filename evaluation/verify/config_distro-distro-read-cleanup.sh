#!/usr/bin/env bash
# Introspection CLEANUP: delete config_distro_eval.data. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_distro_eval.data")->delete();' >/dev/null 2>&1
echo "cleanup: config_distro_eval.data deleted"
