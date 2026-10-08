#!/usr/bin/env bash
# Introspection CLEANUP: remove content type dhv_known. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("dhv_known")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: content type dhv_known removed"
