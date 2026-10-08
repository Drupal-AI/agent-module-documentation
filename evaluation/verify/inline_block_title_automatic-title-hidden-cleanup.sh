#!/usr/bin/env bash
# Introspection CLEANUP: remove ibta_m1. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($nt = NodeType::load("ibta_m1")) { $nt->delete(); }
' >/dev/null 2>&1
echo "cleanup: node.ibta_m1 removed"
