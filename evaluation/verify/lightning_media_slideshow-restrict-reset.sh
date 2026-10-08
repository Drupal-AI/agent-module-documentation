#!/usr/bin/env bash
# Execution RESET: restore the shipped slideshow field configuration - unlimited cardinality
# and no bundle restriction - and remove any slideshow blocks that would block a cardinality
# change, so verify FAILS until the agent applies the new limits. Idempotent. Exit 0.
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
echo "reset: field_slideshow_items unlimited, no target_bundles, no slideshow blocks"
