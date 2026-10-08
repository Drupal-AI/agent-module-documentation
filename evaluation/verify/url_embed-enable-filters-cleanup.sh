#!/usr/bin/env bash
# Execution CLEANUP: remove the namespaced text format url_embed_task created by the
# enable-filters reset. Restores baseline (no such format). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($format = FilterFormat::load("url_embed_task")) { $format->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format url_embed_task removed"
