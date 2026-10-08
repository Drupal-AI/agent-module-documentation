#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\system\Entity\Menu::load("admin")->getThirdPartySetting("domain_menu_access","access_enabled");
  print ($v == TRUE) ? "PASS" : "FAIL";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
