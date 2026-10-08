#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure the node/article redirect does NOT exist (verify FAILS on empty).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("content_translation_redirect.entity.node__article")->delete();' >/dev/null 2>&1
echo "reset: node__article redirect absent"
