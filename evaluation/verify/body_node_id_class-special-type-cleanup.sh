#!/usr/bin/env bash
# Introspection CLEANUP: remove content type bnic_faq. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("bnic_faq")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: content type bnic_faq removed"
