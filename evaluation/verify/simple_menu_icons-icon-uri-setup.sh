#!/usr/bin/env bash
# Introspection SETUP: create a custom menu link whose simple_menu_icons icon points at a
# distinctive file uri, so an agent can read the configured icon path back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($s->getQuery()->accessCheck(FALSE)->condition("title","SMI URI Link")->execute() as $id) { $s->load($id)->delete(); }
  MenuLinkContent::create([
    "title" => "SMI URI Link", "menu_name" => "main",
    "link" => ["uri" => "internal:/node", "options" => ["menu_icon" => ["uri" => "public://menu_icons/smi_dashboard.svg", "fid" => 0]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: main menu 'SMI URI Link' menu_icon.uri = public://menu_icons/smi_dashboard.svg"
