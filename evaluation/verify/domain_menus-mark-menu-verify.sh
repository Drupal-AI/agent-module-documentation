#!/usr/bin/env bash
# Execution VERIFY: PASS when menu domainmenus_task has a non-empty domain_menus.domains
# third-party setting (i.e. _domain_menus_is_domain_menu would return TRUE). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\system\Entity\Menu;
  $m = Menu::load("domainmenus_task");
  $d = $m ? $m->getThirdPartySetting("domain_menus", "domains") : NULL;
  $ok = !empty($d);
  print ($ok ? "PASS" : "FAIL") . " domains=" . var_export($d, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
