#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ns = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["RUC All Node 1","RUC All Node 2"] as $t) {
    foreach ($ns->loadByProperties(["title"=>$t]) as $n) { $n->delete(); }
  }
  foreach (["ruc_source","ruc_dest"] as $name) {
    foreach (\Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name"=>$name]) as $u) { $u->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: RUC All nodes and ruc_source/ruc_dest removed"
