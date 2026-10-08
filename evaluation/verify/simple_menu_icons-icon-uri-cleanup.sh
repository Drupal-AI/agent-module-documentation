#!/usr/bin/env bash
# Introspection CLEANUP: remove the 'SMI URI Link' menu link created by the matching setup.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($s->getQuery()->accessCheck(FALSE)->condition("title","SMI URI Link")->execute() as $id) { $s->load($id)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: SMI URI Link removed"
