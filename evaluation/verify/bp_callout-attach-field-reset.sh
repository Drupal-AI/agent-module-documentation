#!/usr/bin/env bash
# Execution RESET (bp_callout): remove field_bpcallout_task from Article entirely, so the
# agent must create the paragraphs field and allow the Callout bundle on it from scratch.
# verify FAILS on this empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpcallout_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpcallout_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
# Purge the just-deleted field data. Without this Drupal defers the purge and leaves a stale
# last-installed field storage definition behind, which makes later node deletes fail.
drush php:eval 'field_purge_batch(200);' >/dev/null 2>&1
echo "reset: node.article has no field_bpcallout_task"
