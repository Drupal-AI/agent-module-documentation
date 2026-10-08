#!/usr/bin/env bash
# Execution CLEANUP: remove node.article field_eval_recur_w (config + storage) and its
# form-display component, restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_recur_w")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_recur_w")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article field_eval_recur_w removed"
