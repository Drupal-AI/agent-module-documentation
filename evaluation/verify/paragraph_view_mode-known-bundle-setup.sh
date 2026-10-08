#!/usr/bin/env bash
# Introspection SETUP: create TWO paragraph types — pvm_known (Paragraph View Mode ENABLED,
# widget restricted to a specific default view mode) and pvm_plain (feature NOT enabled) — so
# the agent must inspect the live site to tell which bundle carries the paragraph_view_mode
# field and what its widget's default_view_mode is. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  foreach (["pvm_known" => "PVM Known", "pvm_plain" => "PVM Plain"] as $id => $label) {
    if (!ParagraphsType::load($id)) {
      ParagraphsType::create(["id" => $id, "label" => $label])->save();
    }
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("paragraph." . $id . ".default");
    if (!$fd) {
      \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
        "targetEntityType" => "paragraph", "bundle" => $id, "mode" => "default", "status" => TRUE,
      ])->save();
    }
  }
  $sm = \Drupal::service("paragraph_view_mode.storage_manager");
  $sm->addField("pvm_known");
  $sm->addToFormDisplay("pvm_known");
  // Restrict the widget to default+preview and make preview the default value.
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("paragraph.pvm_known.default");
  $c = $fd->getComponent("paragraph_view_mode");
  $c["settings"]["view_modes"] = ["default" => "Default", "preview" => "Preview"];
  $c["settings"]["default_view_mode"] = "preview";
  $c["settings"]["form_mode_bind"] = FALSE;
  $fd->setComponent("paragraph_view_mode", $c)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pvm_known has paragraph_view_mode field (default_view_mode=preview, form_mode_bind=FALSE); pvm_plain does not"
