#!/usr/bin/env bash
# Execution RESET: (re)create menu link 'SMI Target Link' in 'main' with NO icon, so verify
# FAILS until the agent sets the icon to the exact target uri. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($s->getQuery()->accessCheck(FALSE)->condition("title","SMI Target Link")->execute() as $id) { $s->load($id)->delete(); }
  MenuLinkContent::create([
    "title" => "SMI Target Link", "menu_name" => "main",
    "link" => ["uri" => "internal:/node"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: main menu 'SMI Target Link' present with NO menu_icon"
