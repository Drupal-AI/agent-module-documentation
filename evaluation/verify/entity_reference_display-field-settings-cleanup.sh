#!/usr/bin/env bash
# Introspection CLEANUP: remove the probe entity_reference_display field added by the matching
# setup, restoring node.blog_post to baseline. Deletes field config then storage. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "blog_post", "field_erd_probe")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_erd_probe")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.blog_post.field_erd_probe removed"
