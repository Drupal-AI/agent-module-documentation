#!/usr/bin/env bash
# Execution RESET (also serves as cleanup): delete media type mpb_dash and its source field so
# verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("media", "mpb_dash", "field_mpb_dash")) { $fc->delete(); }
  if ($mt = MediaType::load("mpb_dash")) { $mt->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_mpb_dash")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: media type mpb_dash removed (clean)"
