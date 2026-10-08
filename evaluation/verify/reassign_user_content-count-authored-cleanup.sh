#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $us = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => "ruc_bulk"]);
  if ($us) {
    $u = reset($us);
    $ns = \Drupal::entityTypeManager()->getStorage("node");
    $nids = $ns->getQuery()->accessCheck(FALSE)->condition("uid",$u->id())->execute();
    foreach ($ns->loadMultiple($nids) as $n) { $n->delete(); }
    $u->delete();
  }
' >/dev/null 2>&1
echo "cleanup: ruc_bulk and their nodes removed"
