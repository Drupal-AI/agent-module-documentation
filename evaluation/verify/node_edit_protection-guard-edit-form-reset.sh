#!/usr/bin/env bash
# Execution RESET: ensure node_edit_protection enabled; delete any nep_netb nodes and the
# nep_netb content type so verify FAILS until the agent creates the type and a node. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("type", "nep_netb")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(\Drupal::entityTypeManager()->getStorage("node")->loadMultiple($ids)); }
  if ($nt = NodeType::load("nep_netb")) { $nt->delete(); }
' >/dev/null 2>&1
drush pm:install node_edit_protection -y >/dev/null 2>&1 || true
echo "reset: nep_netb type+nodes absent, node_edit_protection enabled"
