#!/usr/bin/env bash
# Introspection CLEANUP: delete the state_change__node__archived action. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Action;
  if ($a = Action::load("state_change__node__archived")) { $a->delete(); }
' >/dev/null 2>&1 || true
echo "cleanup: action state_change__node__archived removed"
