#!/usr/bin/env bash
# Introspection CLEANUP: delete the probe2 state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("twig_real_content_probe2");' >/dev/null 2>&1
echo "cleanup: state twig_real_content_probe2 deleted"
