#!/usr/bin/env bash
# Shared CLEANUP for the execution cases: delete the eval-created custom menu links so the
# site is left at baseline. Idempotent (no-op if already gone). Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("menu_link_content")
    ->getQuery()->accessCheck(FALSE)
    ->condition("title", ["FA Eval Target", "FA Eval Social"], "IN")->execute();
  foreach (\Drupal\menu_link_content\Entity\MenuLinkContent::loadMultiple($ids) as $e) { $e->delete(); }
  print "cleanup: eval menu links removed (FA Eval Target, FA Eval Social)\n";
' 2>/dev/null | grep -a '^cleanup:'
drush cr >/dev/null 2>&1
