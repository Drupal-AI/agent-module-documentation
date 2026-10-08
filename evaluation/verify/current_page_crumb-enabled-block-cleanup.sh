#!/usr/bin/env bash
# Introspection CLEANUP: remove both namespaced breadcrumb blocks created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (["cpc_m_on","cpc_m_off"] as $id) { if ($b = Block::load($id)) { $b->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cpc_m_on and cpc_m_off removed"
