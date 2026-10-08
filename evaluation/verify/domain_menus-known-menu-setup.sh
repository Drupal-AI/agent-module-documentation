#!/usr/bin/env bash
# Introspection SETUP: create a menu 'domainmenus_intro' and mark it as a domain menu by setting a
# non-empty domain_menus.domains third-party setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  $m = Menu::load("domainmenus_intro");
  if (!$m) {
    $m = Menu::create(["id" => "domainmenus_intro", "label" => "Domain Menus Intro Fixture"]);
  }
  $m->setThirdPartySetting("domain_menus", "domains", ["default" => "default"]);
  $m->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: menu domainmenus_intro marked as domain menu (domain_menus.domains set)"
