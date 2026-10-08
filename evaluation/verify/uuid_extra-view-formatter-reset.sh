#!/usr/bin/env bash
# Execution RESET (uuid_extra): ensure the node UUID is NOT rendered on the Article default view
# display, so verify FAILS until the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd->getComponent("uuid")) { $vd->removeComponent("uuid")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article default view display has NO uuid component"
