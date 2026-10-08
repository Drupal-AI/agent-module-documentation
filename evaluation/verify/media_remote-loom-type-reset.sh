#!/usr/bin/env bash
# Execution RESET: remove the mr_task media type entirely (display, field instance, type, and the
# field_mr_task storage if unused) so verify FAILS on empty state. The agent must build the whole
# Remote Media type. Also removes an auto-generated field_media_media_remote instance on the
# bundle, in case a previous attempt used the module's default source field name. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  foreach (["default", "full"] as $mode) {
    if ($d = EntityViewDisplay::load("media.mr_task." . $mode)) { $d->delete(); }
  }
  foreach (\Drupal::entityTypeManager()->getStorage("field_config")->loadByProperties([
    "entity_type" => "media", "bundle" => "mr_task",
  ]) as $fc) { $fc->delete(); }
  if ($t = MediaType::load("mr_task")) { $t->delete(); }
  foreach (["field_mr_task", "field_media_media_remote"] as $fn) {
    if ($fs = FieldStorageConfig::loadByName("media", $fn)) {
      if (count($fs->getBundles()) === 0) { $fs->delete(); }
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media type mr_task removed (no Remote Media type present)"
