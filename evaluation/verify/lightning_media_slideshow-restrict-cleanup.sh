#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped slideshow field configuration.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block_content")->loadByProperties(["type" => "media_slideshow"]) as $b) { $b->delete(); }
  $fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("block_content", "field_slideshow_items");
  $fs->setCardinality(-1)->save();
  $fc = \Drupal\field\Entity\FieldConfig::loadByName("block_content", "media_slideshow", "field_slideshow_items");
  $s = $fc->getSettings();
  $s["handler_settings"]["target_bundles"] = NULL;
  $fc->set("settings", $s)->save();
' >/dev/null 2>&1
echo "cleanup: field_slideshow_items restored (unlimited, all bundles)"
