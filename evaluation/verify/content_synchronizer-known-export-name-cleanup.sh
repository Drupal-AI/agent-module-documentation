#!/usr/bin/env bash
# Introspection CLEANUP: remove the 'CS Staging Bundle' export entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\content_synchronizer\Entity\ExportEntity;
  foreach (ExportEntity::loadMultiple() as $e) {
    if ($e->getName() === "CS Staging Bundle") {
      \Drupal::database()->delete("content_synchronizer_export_items")->condition("export_id", $e->id())->execute();
      $e->delete();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: export_entity 'CS Staging Bundle' removed"
