#!/usr/bin/env bash
# Execution RESET: ensure a plain menu 'domainmenus_task' exists WITHOUT any domain_menus marker
# (so verify FAILS until the agent marks it). Removes any existing domain_menus third-party
# settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  $m = Menu::load("domainmenus_task");
  if (!$m) {
    $m = Menu::create(["id" => "domainmenus_task", "label" => "Domain Menus Task Fixture"]);
  }
  $m->unsetThirdPartySetting("domain_menus", "domains");
  $m->unsetThirdPartySetting("domain_menus", "auto-created");
  $m->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: plain menu domainmenus_task present (no domain_menus marker)"
