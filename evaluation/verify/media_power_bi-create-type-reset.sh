#!/usr/bin/env bash
# Execution RESET (also serves as cleanup): delete media type mpb_report and its namespaced
# source field so the site is clean and verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("media", "mpb_report", "field_mpb_report")) { $fc->delete(); }
  if ($mt = MediaType::load("mpb_report")) { $mt->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_mpb_report")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: media type mpb_report removed (clean)"
