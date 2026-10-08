#!/usr/bin/env bash
# Introspection CLEANUP: remove the namespaced breadcrumb block created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("cpc_m_breadcrumb")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block cpc_m_breadcrumb removed"
