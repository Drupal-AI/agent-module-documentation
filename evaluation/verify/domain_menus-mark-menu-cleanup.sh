#!/usr/bin/env bash
# Execution CLEANUP: delete the fixture menu. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Menu;
  if ($m = Menu::load("domainmenus_task")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: menu domainmenus_task removed"
