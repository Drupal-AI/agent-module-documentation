#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_megamenu\Entity\SimpleMegaMenuType;
  $st = \Drupal::entityTypeManager()->getStorage("simple_mega_menu");
  if ($ids = $st->getQuery()->accessCheck(FALSE)->condition("type", "smm_ct")->execute()) {
    $st->delete($st->loadMultiple($ids));
  }
  if ($t = SimpleMegaMenuType::load("smm_ct")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: smm_ct entities and bundle removed"
