#!/usr/bin/env bash
# Execution CLEANUP: delete nep_netb nodes and content type. Leaves module enabled. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("type", "nep_netb")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(\Drupal::entityTypeManager()->getStorage("node")->loadMultiple($ids)); }
  if ($nt = NodeType::load("nep_netb")) { $nt->delete(); }
' >/dev/null 2>&1
echo "cleanup: nep_netb removed"
