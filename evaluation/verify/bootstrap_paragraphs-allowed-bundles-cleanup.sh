#!/usr/bin/env bash
# Introspection CLEANUP: remove field_bp_eval_allowed from node.article (drops its
# form-display component with it). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bp_eval_allowed")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bp_eval_allowed")) { $fs->delete(); }
  // Purge the deleted field so its table is dropped now rather than at the next cron.
  field_purge_batch(200);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_bp_eval_allowed removed from node.article"
