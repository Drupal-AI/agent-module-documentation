#!/usr/bin/env bash
# Execution RESET: ensure the content type "gtt_task" does NOT exist, so verify FAILS on empty
# state until the agent creates it and configures it for the (Gin) Type Tray. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("gtt_task")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: content type gtt_task absent"
