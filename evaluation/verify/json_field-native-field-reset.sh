#!/usr/bin/env bash
# Execution RESET for "create a JSON (raw) field on Article": remove field_jf_task entirely
# (storage + instance + display components) so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_jf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_jf_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_jf_task removed from node.article"
