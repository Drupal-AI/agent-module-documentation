#!/usr/bin/env bash
# Execution CLEANUP: remove ibta_h2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($nt = NodeType::load("ibta_h2")) { $nt->delete(); }
' >/dev/null 2>&1
echo "cleanup: node.ibta_h2 removed"
