#!/usr/bin/env bash
# Execution RESET: ensure no Link media with the target URL exists, so verify FAILS until built.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityQuery("media")->accessCheck(FALSE)
    ->condition("bundle", "link")
    ->condition("field_media_entity_link.uri", "https://www.drupal.org/mel-task")
    ->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("media")->delete(\Drupal::entityTypeManager()->getStorage("media")->loadMultiple($ids)); }
' >/dev/null 2>&1
echo "reset: no Link media points to https://www.drupal.org/mel-task"
