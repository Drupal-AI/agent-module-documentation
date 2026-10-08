#!/usr/bin/env bash
# Execution CLEANUP: same as reset - drop every formblock_node block instance.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "formblock_node") { $b->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: formblock_node block instances removed"
