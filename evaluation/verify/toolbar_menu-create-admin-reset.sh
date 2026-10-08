#!/usr/bin/env bash
# Reset for the "add the admin menu to the toolbar with rewrite_label" task: delete any
# toolbar_menu_element config entity targeting the `admin` menu so the agent must build one.
set -uo pipefail
cd /var/www/html
drush php:eval '
  error_reporting(E_ERROR);
  $s = \Drupal::entityTypeManager()->getStorage("toolbar_menu_element");
  foreach ($s->loadMultiple() as $id => $e) {
    if ($e->get("menu") === "admin") { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: toolbar_menu_element entities targeting the admin menu removed"
