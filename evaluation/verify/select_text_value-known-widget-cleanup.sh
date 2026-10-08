#!/usr/bin/env bash
# Introspection CLEANUP: remove field_stv_known storage (cascades the instance + display
# component) and the stv_content content type. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fs = FieldStorageConfig::loadByName("node", "field_stv_known")) { $fs->delete(); }
  if ($t = NodeType::load("stv_content")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_stv_known and stv_content removed"
