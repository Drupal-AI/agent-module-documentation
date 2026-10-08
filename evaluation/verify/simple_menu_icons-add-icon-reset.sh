#!/usr/bin/env bash
# Execution RESET: (re)create a custom menu link 'SMI Task Link' in the 'main' menu WITHOUT
# any simple_menu_icons icon, so the verify script FAILS until the agent adds one. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($s->getQuery()->accessCheck(FALSE)->condition("title","SMI Task Link")->execute() as $id) { $s->load($id)->delete(); }
  MenuLinkContent::create([
    "title" => "SMI Task Link", "menu_name" => "main",
    "link" => ["uri" => "internal:/node"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: main menu 'SMI Task Link' present with NO menu_icon"
