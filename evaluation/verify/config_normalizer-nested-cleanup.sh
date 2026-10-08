#!/usr/bin/env bash
# Introspection CLEANUP: delete config_normalizer_eval.nested. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_normalizer_eval.nested")->delete();' >/dev/null 2>&1
echo "cleanup: config_normalizer_eval.nested deleted"
