#!/usr/bin/env bash
# Introspection CLEANUP: delete paragraph type pvm_known. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  if ($pt = ParagraphsType::load("pvm_known")) { $pt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: paragraphs_type pvm_known removed"
