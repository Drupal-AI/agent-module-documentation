#!/usr/bin/env bash
# Execution RESET: ensure field_srt_task does NOT exist on Article (remove display component +
# field) so verify FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd && $vd->getComponent("field_srt_task")) { $vd->removeComponent("field_srt_task")->save(); }
  if ($fc = FieldConfig::loadByName("node","article","field_srt_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_srt_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_srt_task absent"
