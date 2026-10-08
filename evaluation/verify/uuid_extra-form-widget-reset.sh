#!/usr/bin/env bash
# Execution RESET (uuid_extra): ensure the node UUID is NOT on the Article default form display,
# so verify FAILS until the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd->getComponent("uuid")) { $fd->removeComponent("uuid")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article default form display has NO uuid component"
