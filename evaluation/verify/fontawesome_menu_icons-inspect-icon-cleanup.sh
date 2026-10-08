#!/usr/bin/env bash
# Introspection CLEANUP: delete the known "FA Eval Known" menu link, restoring baseline.
# Idempotent: no-op if already gone. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("menu_link_content")
    ->getQuery()->accessCheck(FALSE)->condition("title", "FA Eval Known")->execute();
  foreach (\Drupal\menu_link_content\Entity\MenuLinkContent::loadMultiple($ids) as $e) { $e->delete(); }
  print "cleanup: menu link \"FA Eval Known\" removed\n";
' 2>/dev/null | grep -a '^cleanup:'
drush cr >/dev/null 2>&1
