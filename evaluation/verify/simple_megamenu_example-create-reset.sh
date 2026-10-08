#!/usr/bin/env bash
# Execution RESET: remove any simple_mega_menu entity named 'Example Promo' in the example's
# 'megamenu' bundle, so verify FAILS until the agent creates it. Ensures the submodule is enabled
# (its bundle must exist). Does NOT touch the bundle or other entities. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx simple_megamenu_example; then
  drush en simple_megamenu_example -y >/dev/null 2>&1
fi
drush php:eval '
  $st = \Drupal::entityTypeManager()->getStorage("simple_mega_menu");
  $ids = $st->getQuery()->accessCheck(FALSE)->condition("type", "megamenu")->condition("name", "Example Promo")->execute();
  if ($ids) { $st->delete($st->loadMultiple($ids)); }
' >/dev/null 2>&1
echo "reset: no 'Example Promo' megamenu entity present"
