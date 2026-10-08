#!/usr/bin/env bash
# Execution CLEANUP: delete paragraph type pvm_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  if ($pt = ParagraphsType::load("pvm_task")) { $pt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: paragraphs_type pvm_task removed"
