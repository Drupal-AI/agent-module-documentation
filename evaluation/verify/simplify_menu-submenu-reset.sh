#!/usr/bin/env bash
# Execution RESET: remove the parent/child links this task builds, so verify FAILs on empty
# state. Deletes any menu links titled "Products" or "Widgets", rebuilds links, clears menu
# cache. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach (["Products", "Widgets"] as $t) {
    foreach ($s->loadByProperties(["title" => $t]) as $l) { $l->delete(); }
  }
  \Drupal::service("plugin.manager.menu.link")->rebuild();
  \Drupal::cache("menu")->deleteAll();
' >/dev/null 2>&1
echo "reset: removed any 'Products'/'Widgets' menu links (build target not met)"
