#!/usr/bin/env bash
# Execution RESET: ensure Image field field_ift_disp exists on Article with the core image_image
# widget and preview_image_style 'medium', so verify FAILS until the agent switches the widget to
# imagefield_tokens with preview_image_style 'thumbnail'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ift_disp")) { FieldStorageConfig::create(["field_name"=>"field_ift_disp","entity_type"=>"node","type"=>"image","cardinality"=>1])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ift_disp")) { FieldConfig::create(["field_name"=>"field_ift_disp","entity_type"=>"node","bundle"=>"article","label"=>"IFT Disp"])->save(); }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_ift_disp", ["type"=>"image_image","weight"=>50,"region"=>"content","settings"=>["preview_image_style"=>"medium"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ift_disp uses core image_image widget"
