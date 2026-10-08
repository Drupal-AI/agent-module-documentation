#!/usr/bin/env bash
# Introspection CLEANUP: remove content type nep_med. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($nt = NodeType::load("nep_med")) { $nt->delete(); }
' >/dev/null 2>&1
echo "cleanup: content type nep_med removed"
