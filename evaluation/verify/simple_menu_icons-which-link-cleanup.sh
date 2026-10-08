#!/usr/bin/env bash
# Introspection CLEANUP: remove the menu links created by the matching setup.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach (["SMI Known Icon Link","SMI Plain Link"] as $t) {
    foreach ($s->getQuery()->accessCheck(FALSE)->condition("title",$t)->execute() as $id) { $s->load($id)->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: SMI test menu links removed"
