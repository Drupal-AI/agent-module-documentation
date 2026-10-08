#!/usr/bin/env bash
# Execution RESET: ensure field_micon_task does NOT exist on Article, so the string_micon field
# must be built by the agent (verify FAILs on empty state). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_micon_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_micon_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_micon_task absent from node.article"
