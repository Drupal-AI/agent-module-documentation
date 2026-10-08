#!/usr/bin/env bash
# Execution RESET for menu clone: ensure a source menu mm_mig_src exists with one known content
# link, and a target menu mm_mig_dst exists but has NO content links (so verify FAILS until the
# agent clones). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  foreach (["mm_mig_src" => "MM Migration Source", "mm_mig_dst" => "MM Migration Target"] as $id => $label) {
    if (!Menu::load($id)) { Menu::create(["id" => $id, "label" => $label])->save(); }
  }
  // Wipe any content links in either menu.
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach (["mm_mig_src", "mm_mig_dst"] as $m) {
    $ids = $storage->getQuery()->accessCheck(FALSE)->condition("menu_name", $m)->execute();
    if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  }
  // Seed one link in the source only.
  MenuLinkContent::create([
    "title" => "MM Home", "link" => ["uri" => "internal:/"], "menu_name" => "mm_mig_src",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mm_mig_src has 1 link, mm_mig_dst empty"
