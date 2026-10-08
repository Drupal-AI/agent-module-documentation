#!/usr/bin/env bash
# Introspection CLEANUP: remove we_mm_a / we_mm_b menus and their megamenu rows.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  foreach (["we_mm_a", "we_mm_b"] as $id) {
    \Drupal::database()->delete("we_megamenu")->condition("menu_name", $id)->execute();
    if ($m = Menu::load($id)) { $m->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed we_mm_a, we_mm_b and their megamenu rows"
