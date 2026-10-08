#!/usr/bin/env bash
# Introspection SETUP: create paragraph type pvm_prev with the Paragraph View Mode field
# enabled and the widget's "Apply to preview mode" (apply_to_preview) turned ON, while
# "Bind with the form mode" (form_mode_bind) is left ON too. The agent must read the live
# form-display component to report the apply_to_preview value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  if (!ParagraphsType::load("pvm_prev")) {
    ParagraphsType::create(["id" => "pvm_prev", "label" => "PVM Preview"])->save();
  }
  $storage = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  if (!$storage->load("paragraph.pvm_prev.default")) {
    $storage->create([
      "targetEntityType" => "paragraph", "bundle" => "pvm_prev", "mode" => "default", "status" => TRUE,
    ])->save();
  }
  $sm = \Drupal::service("paragraph_view_mode.storage_manager");
  $sm->addField("pvm_prev");
  $sm->addToFormDisplay("pvm_prev");
  $fd = $storage->load("paragraph.pvm_prev.default");
  $c = $fd->getComponent("paragraph_view_mode");
  $c["settings"]["apply_to_preview"] = TRUE;
  $c["settings"]["form_mode_bind"] = TRUE;
  $fd->setComponent("paragraph_view_mode", $c)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: paragraph.pvm_prev.default widget has apply_to_preview=TRUE"
