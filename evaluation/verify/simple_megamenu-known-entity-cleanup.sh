#!/usr/bin/env bash
# Introspection CLEANUP: delete smm_probe entities and the bundle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_megamenu\Entity\SimpleMegaMenuType;
  $st = \Drupal::entityTypeManager()->getStorage("simple_mega_menu");
  if ($ids = $st->getQuery()->accessCheck(FALSE)->condition("type", "smm_probe")->execute()) {
    $st->delete($st->loadMultiple($ids));
  }
  if ($t = SimpleMegaMenuType::load("smm_probe")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: smm_probe entities and bundle removed"
