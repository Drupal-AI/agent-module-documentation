#!/usr/bin/env bash
# Execution RESET for "nest the Cameras term link under the existing Shop link".
# Creates the tmui_shop_menu menu, the tmui_shop vocabulary wired for taxonomy_menu_ui, a
# TOP-LEVEL 'Shop' menu link that will act as the parent, and the 'Cameras' term — but NO
# link for that term, so verify FAILS until the agent creates a correctly parented one.
# Any stale term link is removed.
# NOTE: the menu + vocabulary are created in a FIRST drush call and the term/links in a
# SECOND one — creating terms in a bundle registered in the same PHP process runs against
# stale bundle info. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  if (!Menu::load("tmui_shop_menu")) {
    Menu::create(["id" => "tmui_shop_menu", "label" => "TMUI Shop", "description" => "Eval menu"])->save();
  }
  $v = Vocabulary::load("tmui_shop") ?: Vocabulary::create(["vid" => "tmui_shop", "name" => "TMUI Shop"]);
  $v->setThirdPartySetting("menu_ui", "available_menus", ["tmui_shop_menu"]);
  $v->setThirdPartySetting("menu_ui", "parent", "tmui_shop_menu:");
  $v->save();
' >/dev/null 2>&1
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $terms = $ts->loadByProperties(["vid" => "tmui_shop", "name" => "Cameras"]);
  if ($terms) { $term = reset($terms); }
  else { $term = Term::create(["vid" => "tmui_shop", "name" => "Cameras"]); $term->save(); }
  $mlc = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  // Drop any link pointing at the term (leftover from a previous attempt).
  foreach ($mlc->loadByProperties(["link__uri" => "internal:/taxonomy/term/" . $term->id()]) as $l) { $l->delete(); }
  // Ensure exactly one top-level Shop parent link exists.
  $shop = $mlc->loadByProperties(["menu_name" => "tmui_shop_menu", "title" => "Shop"]);
  if (!$shop) {
    MenuLinkContent::create([
      "title" => "Shop", "link" => ["uri" => "internal:/"], "menu_name" => "tmui_shop_menu",
      "parent" => "", "weight" => 0, "enabled" => 1,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tmui_shop_menu has only the top-level 'Shop' link; term Cameras exists with no menu link"
