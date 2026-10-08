#!/usr/bin/env bash
# Reset for the "add the main menu to the toolbar" task: delete any toolbar_menu_element
# config entity targeting the `main` menu so the agent must build one.
set -uo pipefail
cd /var/www/html
drush php:eval '
  error_reporting(E_ERROR);
  $s = \Drupal::entityTypeManager()->getStorage("toolbar_menu_element");
  foreach ($s->loadMultiple() as $id => $e) {
    if ($e->get("menu") === "main") { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: toolbar_menu_element entities targeting the main menu removed"
