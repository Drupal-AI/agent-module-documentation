#!/usr/bin/env bash
# Introspection CLEANUP: remove the namespaced text format url_embed_test created by the
# matching setup. Restores baseline (no such format). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($format = FilterFormat::load("url_embed_test")) { $format->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format url_embed_test removed"
