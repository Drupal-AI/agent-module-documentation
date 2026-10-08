#!/usr/bin/env bash
# Execution RESET: ensure content type dhv_task is ABSENT so verify fails on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("dhv_task")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: content type dhv_task removed (absent)"
