#!/usr/bin/env bash
# Execution CLEANUP: remove content type nep_neta. Leaves node_edit_protection enabled. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($nt = NodeType::load("nep_neta")) { $nt->delete(); }
' >/dev/null 2>&1
echo "cleanup: nep_neta removed"
