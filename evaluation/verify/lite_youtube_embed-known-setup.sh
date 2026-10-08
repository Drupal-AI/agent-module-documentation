#!/usr/bin/env bash
# Introspection SETUP: create a namespaced media view mode 'ly_probe' and a remote_video display in
# that mode whose oEmbed video field uses the lite_youtube_embed formatter (max_width 640), so an
# agent can read which formatter/settings are used. Does NOT touch remote_video's default display.
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
  $vd->setComponent($sf, ["type"=>"lite_youtube_embed","settings"=>["max_width"=>640,"max_height"=>0],"label"=>"hidden","weight"=>0,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media.remote_video.ly_probe uses lite_youtube_embed (max_width=640)"
