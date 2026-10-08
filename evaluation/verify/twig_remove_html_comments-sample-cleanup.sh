#!/usr/bin/env bash
# Introspection CLEANUP: delete the sample state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("twig_remove_html_comments_sample");' >/dev/null 2>&1
echo "cleanup: state twig_remove_html_comments_sample deleted"
