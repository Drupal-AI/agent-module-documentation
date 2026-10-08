#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore the moderated_group_content pager to the shipped 50 so verify
# FAILS on empty state (not 25). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("moderated_group_content");
  if ($v) { $d = $v->get("display"); $d["default"]["display_options"]["pager"]["options"]["items_per_page"] = 50; $v->set("display", $d)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: moderated_group_content pager items_per_page=50"
