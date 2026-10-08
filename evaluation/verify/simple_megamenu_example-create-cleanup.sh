#!/usr/bin/env bash
# Execution CLEANUP: delete the 'Example Promo' megamenu entity created during the case. Leaves the
# shipped bundle intact. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $st = \Drupal::entityTypeManager()->getStorage("simple_mega_menu");
  $ids = $st->getQuery()->accessCheck(FALSE)->condition("type", "megamenu")->condition("name", "Example Promo")->execute();
  if ($ids) { $st->delete($st->loadMultiple($ids)); }
' >/dev/null 2>&1
echo "cleanup: 'Example Promo' megamenu entity removed"
