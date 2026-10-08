#!/usr/bin/env bash
# Execution CLEANUP: delete the Link media that points to the target URL. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityQuery("media")->accessCheck(FALSE)
    ->condition("bundle", "link")
    ->condition("field_media_entity_link.uri", "https://www.drupal.org/mel-task")
    ->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("media")->delete(\Drupal::entityTypeManager()->getStorage("media")->loadMultiple($ids)); }
' >/dev/null 2>&1
echo "cleanup: target Link media removed"
