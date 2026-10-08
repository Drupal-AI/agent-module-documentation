#!/usr/bin/env bash
# Introspection SETUP: create image style ac_known with an Automated Crop effect using crop type
# 'freeform' and provider 'automated_crop_default', so an agent can read them back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("ac_known")) { $s->delete(); }
  $s = ImageStyle::create(["name" => "ac_known", "label" => "AC Known"]);
  $s->addImageEffect(["id" => "automated_crop", "weight" => 1, "data" => ["crop_type" => "freeform", "automatic_crop_provider" => "automated_crop_default"]]);
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image style ac_known has automated_crop effect (crop_type freeform, provider automated_crop_default)"
