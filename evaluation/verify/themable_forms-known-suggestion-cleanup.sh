#!/usr/bin/env bash
# themable_forms cleanup: remove content type themf_disc. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("themf_disc")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: content type themf_disc removed"
