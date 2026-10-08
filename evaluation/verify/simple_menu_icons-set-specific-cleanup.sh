#!/usr/bin/env bash
# Execution CLEANUP: remove the 'SMI Target Link' menu link (leave the site clean).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($s->getQuery()->accessCheck(FALSE)->condition("title","SMI Target Link")->execute() as $id) { $s->load($id)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: SMI Target Link removed"
