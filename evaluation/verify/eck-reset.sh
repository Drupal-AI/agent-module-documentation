#!/usr/bin/env bash
# Reset ECK to a clean baseline before each hard (execution) eval run: delete the ECK
# entity types the hard cases build (`country`, `venue`) along with their bundles, which
# uninstalls the dynamic content entity types and drops their DB tables. Idempotent — a
# missing type is skipped. Mirrors the pathauto-reset.sh idiom.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["country", "venue"] as $id) {
    $type = \Drupal\eck\Entity\EckEntityType::load($id);
    if ($type) {
      if (\Drupal::entityTypeManager()->hasDefinition($id . "_type")) {
        foreach (\Drupal::entityTypeManager()->getStorage($id . "_type")->loadMultiple() as $b) { $b->delete(); }
      }
      $type->delete();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ECK types country + venue removed (tables dropped), baseline restored"
