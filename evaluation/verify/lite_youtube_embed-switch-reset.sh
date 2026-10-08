#!/usr/bin/env bash
# Execution RESET: create the ly_probe remote_video display with the DEFAULT core 'oembed' formatter
# on the video field (so verify FAILS until the agent switches it to lite_youtube_embed).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  $vmid = "media.ly_probe";
  $vms = \Drupal::entityTypeManager()->getStorage("entity_view_mode");
  if (!$vms->load($vmid)) { $vms->create(["id"=>$vmid,"targetEntityType"=>"media","label"=>"LY Probe"])->save(); }
  $type = MediaType::load("remote_video");
  $sf = $type->getSource()->getSourceFieldDefinition($type)->getName();
  $etm = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $etm->load("media.remote_video.ly_probe") ?: $etm->create(["targetEntityType"=>"media","bundle"=>"remote_video","mode"=>"ly_probe","status"=>TRUE]);
  $vd->setComponent($sf, ["type"=>"oembed","settings"=>["max_width"=>0,"max_height"=>0],"label"=>"hidden","weight"=>0,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media.remote_video.ly_probe video field uses core oembed formatter"
