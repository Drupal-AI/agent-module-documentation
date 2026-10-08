#!/usr/bin/env bash
# Execution RESET: ensure entitygroupfield is hidden so verify FAILS until placed.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($fd && $fd->getComponent("entitygroupfield")) { $fd->removeComponent("entitygroupfield")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: entitygroupfield hidden on user form"
