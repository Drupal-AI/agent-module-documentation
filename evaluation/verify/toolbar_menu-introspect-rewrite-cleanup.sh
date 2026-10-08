#!/usr/bin/env bash
# Introspection CLEANUP: remove the known eval_tb_main toolbar_menu_element.
set -uo pipefail
cd /var/www/html
drush php:eval '
  error_reporting(E_ERROR);
  if ($e = \Drupal::entityTypeManager()->getStorage("toolbar_menu_element")->load("eval_tb_main")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: toolbar_menu_element eval_tb_main removed"
