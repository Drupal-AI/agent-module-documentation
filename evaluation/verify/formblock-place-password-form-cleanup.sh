#!/usr/bin/env bash
# Execution CLEANUP: drop every formblock_user_password block instance.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "formblock_user_password") { $b->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: formblock_user_password block instances removed"
