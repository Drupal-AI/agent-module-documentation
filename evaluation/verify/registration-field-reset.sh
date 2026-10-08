#!/usr/bin/env bash
# Execution RESET: ensure the Registration field field_reg_event does NOT exist on node.article,
# so verify fails until the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_reg_event")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_reg_event")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: node.article field_reg_event absent"
