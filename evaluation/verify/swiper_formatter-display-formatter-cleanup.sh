#!/usr/bin/env bash
# Introspection CLEANUP: remove field_sf_txt (drops its display component) and sf_known.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\swiper_formatter\Entity\SwiperFormatter;
  if ($fc = FieldConfig::loadByName("node","article","field_sf_txt")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_sf_txt")) { $fs->delete(); }
  if ($e = SwiperFormatter::load("sf_known")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_sf_txt and sf_known removed"
