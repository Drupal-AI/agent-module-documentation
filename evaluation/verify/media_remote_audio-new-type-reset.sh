#!/usr/bin/env bash
# Execution RESET/CLEANUP: remove the mra_podcast media type and its source field so verify
# fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($t = \Drupal::entityTypeManager()->getStorage("media_type")->load("mra_podcast")) {
    $sc = $t->get("source_configuration");
    $sf = $sc["source_field"] ?? NULL;
    $t->delete();
    if ($sf) {
      if ($fc = FieldConfig::loadByName("media", "mra_podcast", $sf)) { $fc->delete(); }
      if ($fs = FieldStorageConfig::loadByName("media", $sf)) { $fs->delete(); }
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mra_podcast media type removed"
