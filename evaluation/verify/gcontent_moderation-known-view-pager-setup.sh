#!/usr/bin/env bash
# Introspection SETUP: set the moderated_group_content view pager items_per_page to 33. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("moderated_group_content");
  if ($v) { $d = $v->get("display"); $d["default"]["display_options"]["pager"]["options"]["items_per_page"] = 33; $v->set("display", $d)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: moderated_group_content pager items_per_page=33"
