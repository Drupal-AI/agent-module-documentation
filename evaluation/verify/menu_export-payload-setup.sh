#!/usr/bin/env bash
# Introspection SETUP: create menu "menuexp_data" with a link, select it, and populate
# menu_export.export_data via the module's export logic, so an agent can read the exported
# payload. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  use Drupal\menu_link_content\Entity\MenuLinkContent;
  if (!Menu::load("menuexp_data")) { Menu::create(["id"=>"menuexp_data","label"=>"MenuExp Data"])->save(); }
  $ids = \Drupal::entityQuery("menu_link_content")->accessCheck(FALSE)->condition("menu_name","menuexp_data")->execute();
  if (!$ids) { MenuLinkContent::create(["title"=>"Exported Data Link","link"=>["uri"=>"internal:/user"],"menu_name"=>"menuexp_data"])->save(); }
  \Drupal::configFactory()->getEditable("menu_export.settings")->set("menus",["menuexp_data"])->save();
  // Same logic as MenuExportForm::exportMenus() (the Export admin form).
  $config = \Drupal::configFactory()->getEditable("menu_export.export_data");
  $config->delete()->save();
  $linkIds = \Drupal::entityQuery("menu_link_content")->accessCheck(FALSE)->condition("menu_name","menuexp_data")->execute();
  foreach (MenuLinkContent::loadMultiple($linkIds) as $link) {
    $linkData = [];
    foreach ($link->toArray() as $key=>$item) { $linkData[$key] = reset($item); }
    $config->set($link->id(), $linkData);
  }
  $config->save();
' >/dev/null 2>&1
echo "setup: menu_export.export_data populated for menuexp_data (link 'Exported Data Link')"
