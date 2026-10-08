#!/usr/bin/env bash
# Execution CLEANUP: delete the nmr_task block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("nmr_task")) { $b->delete(); }
' >/dev/null 2>&1
echo "cleanup: block nmr_task removed"
