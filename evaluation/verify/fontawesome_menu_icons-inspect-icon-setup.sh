#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN custom menu link carrying a Font Awesome icon so an
# inspecting agent can read the icon back via drush. Creates a menu_link_content entity
# titled "FA Eval Known" in the `main` menu with link options
# fa_icon=fa-rocket / fa_icon_prefix=fa-solid / fa_icon_tag=i / fa_icon_appearance=after.
# Idempotent: deletes any prior copy (matched by title) first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("menu_link_content")
    ->getQuery()->accessCheck(FALSE)->condition("title", "FA Eval Known")->execute();
  foreach (\Drupal\menu_link_content\Entity\MenuLinkContent::loadMultiple($ids) as $e) { $e->delete(); }
  $ml = \Drupal\menu_link_content\Entity\MenuLinkContent::create([
    "title" => "FA Eval Known",
    "menu_name" => "main",
    "link" => ["uri" => "route:<front>", "options" => [
      "fa_icon" => "fa-rocket",
      "fa_icon_prefix" => "fa-solid",
      "fa_icon_tag" => "i",
      "fa_icon_appearance" => "after",
    ]],
  ]);
  $ml->save();
  print "setup: menu_link_content \"FA Eval Known\" id=" . $ml->id() . " icon=fa-rocket prefix=fa-solid appearance=after\n";
' 2>/dev/null | grep -a '^setup:'
drush cr >/dev/null 2>&1
