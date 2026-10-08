#!/usr/bin/env bash
# Introspection CLEANUP: delete content type hct_probe. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($nt = NodeType::load("hct_probe")) { $nt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: content type hct_probe removed"
