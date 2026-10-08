#!/usr/bin/env bash
# Introspection CLEANUP: delete the node__article redirect. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("content_translation_redirect.entity.node__article")->delete();' >/dev/null 2>&1
echo "cleanup: node__article redirect removed"
