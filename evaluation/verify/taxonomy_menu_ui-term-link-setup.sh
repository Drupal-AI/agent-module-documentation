#!/usr/bin/env bash
# Introspection SETUP: build a vocabulary tmui_regions wired to a tmui_nav menu via
# taxonomy_menu_ui, create two terms, and give ONE of them the menu_link_content entity that
# taxonomy_menu_ui creates (link.uri = internal:/taxonomy/term/<tid>) with a menu link title
# that deliberately differs from the term name. The agent must inspect the live site to say
# which term is in the menu / under what link title.
# NOTE: the menu + vocabulary are created in a FIRST drush call and the terms/links in a
# SECOND one — creating terms in a bundle registered in the same PHP process runs against
# stale bundle info. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\system\Entity\Menu;
  if (!Menu::load("tmui_nav")) {
    Menu::create(["id" => "tmui_nav", "label" => "TMUI Nav", "description" => "Eval menu"])->save();
  }
  $v = Vocabulary::load("tmui_regions") ?: Vocabulary::create(["vid" => "tmui_regions", "name" => "TMUI Regions"]);
  $v->setThirdPartySetting("menu_ui", "available_menus", ["tmui_nav"]);
  $v->setThirdPartySetting("menu_ui", "parent", "tmui_nav:");
  $v->save();
' >/dev/null 2>&1
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $tids = [];
  foreach (["Northern Highlands", "Southern Lowlands"] as $name) {
    $existing = $ts->loadByProperties(["vid" => "tmui_regions", "name" => $name]);
    if ($existing) { $tids[$name] = reset($existing)->id(); continue; }
    $t = Term::create(["vid" => "tmui_regions", "name" => $name]);
    $t->save();
    $tids[$name] = $t->id();
  }
  $tid = $tids["Northern Highlands"];
  $uri = "internal:/taxonomy/term/" . $tid;
  $mlc = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $found = $mlc->loadByProperties(["link__uri" => $uri, "menu_name" => "tmui_nav"]);
  if (!$found) {
    MenuLinkContent::create([
      "title" => "Highlands Guide",
      "description" => "Regional landing page",
      "link" => ["uri" => $uri],
      "menu_name" => "tmui_nav",
      "parent" => "",
      "weight" => 3,
      "enabled" => 1,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tmui_regions terms created; term 'Northern Highlands' has a tmui_nav link titled 'Highlands Guide'"
