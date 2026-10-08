#!/usr/bin/env bash
# Execution CLEANUP (uuid_extra): remove the uuid component from the Article form display. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd->getComponent("uuid")) { $fd->removeComponent("uuid")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: uuid removed from node.article default form display"
