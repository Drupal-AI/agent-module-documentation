#!/usr/bin/env bash
# Execution RESET: ensure NO embedded_content button 'ec_task' exists, so verify FAILs until the agent
# creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\embedded_content\Entity\EmbeddedContentButton;
  if ($e = EmbeddedContentButton::load("ec_task")) { $e->delete(); }
' >/dev/null 2>&1
echo "reset: no embedded_content button ec_task"
