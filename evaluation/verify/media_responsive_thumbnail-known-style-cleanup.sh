#!/usr/bin/env bash
# Introspection CLEANUP: remove the mrt_ct content type, its field_mrt_media field, and the
# mrt_style responsive image style created by the matching setup. Restores baseline
# (no mrt_* content type/field/style on the site). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\responsive_image\Entity\ResponsiveImageStyle;

  if ($fc = FieldConfig::loadByName("node", "mrt_ct", "field_mrt_media")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_mrt_media")) { $fs->delete(); }
  if ($style = ResponsiveImageStyle::load("mrt_style")) { $style->delete(); }
  if ($nt = NodeType::load("mrt_ct")) { $nt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mrt_ct content type, field_mrt_media, and mrt_style removed"
