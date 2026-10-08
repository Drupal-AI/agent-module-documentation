#!/usr/bin/env bash
# Execution RESET: ensure media type mes_podcast does NOT exist (so verify FAILS on empty state),
# and clean leftover source fields it might have used. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($t = MediaType::load("mes_podcast")) { $t->delete(); }
  foreach (["field_media_soundcloud", "field_mes_purl"] as $fn) {
    if ($fc = FieldConfig::loadByName("media", "mes_podcast", $fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("media", $fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mes_podcast removed"
