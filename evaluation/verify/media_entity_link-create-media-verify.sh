#!/usr/bin/env bash
# Execution VERIFY: PASS when a media entity of bundle 'link' exists whose field_media_entity_link
# URI is https://www.drupal.org/mel-task. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityQuery("media")->accessCheck(FALSE)
    ->condition("bundle", "link")
    ->condition("field_media_entity_link.uri", "https://www.drupal.org/mel-task")
    ->execute();
  print ($ids ? "PASS" : "FAIL") . " matches=" . count($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
