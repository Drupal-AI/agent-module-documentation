#!/usr/bin/env bash
# Execution RESET for "add an entity_reference_display field to a content type". Ensures a
# CLEAN empty state so verify FAILS until the agent builds it: delete any field named
# field_display_mode on node.article (config then storage). Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_display_mode")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_display_mode")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.field_display_mode cleared (agent must create it)"
