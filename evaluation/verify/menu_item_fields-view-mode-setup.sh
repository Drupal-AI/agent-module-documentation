#!/usr/bin/env bash
# Introspection SETUP: create view mode mif_mega + enabled view display for menu_link_content.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vms = \Drupal::entityTypeManager()->getStorage("entity_view_mode");
  if (!$vms->load("menu_link_content.mif_mega")) {
    $vms->create(["id" => "menu_link_content.mif_mega", "targetEntityType" => "menu_link_content", "label" => "MIF Mega"])->save();
  }
  $vds = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  if (!$vds->load("menu_link_content.menu_link_content.mif_mega")) {
    $vds->create(["targetEntityType" => "menu_link_content", "bundle" => "menu_link_content", "mode" => "mif_mega", "status" => TRUE])->save();
  }
' >/dev/null 2>&1
echo "setup: view mode mif_mega created for menu_link_content"
