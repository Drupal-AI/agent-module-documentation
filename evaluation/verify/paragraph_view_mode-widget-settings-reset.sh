#!/usr/bin/env bash
# Execution RESET: create paragraph type pvm_cfg with a "teaser" paragraph view mode available,
# enable the Paragraph View Mode field on it, and force the widget back to its shipped defaults
# (all view modes ticked, default_view_mode=default, form_mode_bind=TRUE, apply_to_preview=FALSE)
# so verify FAILS until the agent restricts the options and changes the settings.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\Core\Entity\Entity\EntityViewMode;
  if (!EntityViewMode::load("paragraph.pvm_teaser")) {
    EntityViewMode::create([
      "id" => "paragraph.pvm_teaser", "targetEntityType" => "paragraph",
      "label" => "PVM Teaser", "status" => TRUE,
    ])->save();
  }
  if (!ParagraphsType::load("pvm_cfg")) {
    ParagraphsType::create(["id" => "pvm_cfg", "label" => "PVM Config"])->save();
  }
  $fdStorage = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  if (!$fdStorage->load("paragraph.pvm_cfg.default")) {
    $fdStorage->create([
      "targetEntityType" => "paragraph", "bundle" => "pvm_cfg", "mode" => "default", "status" => TRUE,
    ])->save();
  }
  // Enable the pvm_teaser view mode for this bundle so the widget can offer it.
  $vdStorage = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  if (!$vdStorage->load("paragraph.pvm_cfg.pvm_teaser")) {
    $vdStorage->create([
      "targetEntityType" => "paragraph", "bundle" => "pvm_cfg",
      "mode" => "pvm_teaser", "status" => TRUE,
    ])->save();
  }
  $sm = \Drupal::service("paragraph_view_mode.storage_manager");
  $sm->addField("pvm_cfg");
  $sm->addToFormDisplay("pvm_cfg");
  // Force shipped defaults.
  $fd = $fdStorage->load("paragraph.pvm_cfg.default");
  $c = $fd->getComponent("paragraph_view_mode");
  $c["settings"]["view_modes"] = ["default" => "Default", "preview" => "Preview", "pvm_teaser" => "PVM Teaser"];
  $c["settings"]["default_view_mode"] = "default";
  $c["settings"]["form_mode_bind"] = TRUE;
  $c["settings"]["apply_to_preview"] = FALSE;
  $fd->setComponent("paragraph_view_mode", $c)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: pvm_cfg widget at shipped defaults (default_view_mode=default, form_mode_bind=TRUE)"
