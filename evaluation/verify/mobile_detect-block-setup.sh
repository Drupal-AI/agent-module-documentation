#!/usr/bin/env bash
# Introspection SETUP: place a Mobile Detect Status block restricted to the iOS platform. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if (!Block::load("mdeval_known")) {
    Block::create([
      "id" => "mdeval_known",
      "theme" => $theme,
      "region" => "content",
      "weight" => 0,
      "plugin" => "mobile_detect_status_block",
      "settings" => ["id"=>"mobile_detect_status_block","label"=>"MD Eval Known","label_display"=>"0","provider"=>"mobile_detect"],
      "visibility" => [
        "mobile_detect_platform" => ["id"=>"mobile_detect_platform","platform"=>["ios"=>"ios"],"negate"=>false],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block mdeval_known (mobile_detect_status_block) restricted to platform ios"
