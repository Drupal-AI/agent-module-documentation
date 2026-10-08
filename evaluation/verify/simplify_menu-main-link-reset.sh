#!/usr/bin/env bash
# Execution RESET: ensure the target link does NOT exist, so verify FAILs on empty state.
# Deletes any menu link titled "Docs Home" from every menu, rebuilds links, clears menu cache.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($s->loadByProperties(["title" => "Docs Home"]) as $l) { $l->delete(); }
  \Drupal::service("plugin.manager.menu.link")->rebuild();
  \Drupal::cache("menu")->deleteAll();
' >/dev/null 2>&1
echo "reset: removed any 'Docs Home' menu link (build target not met)"
