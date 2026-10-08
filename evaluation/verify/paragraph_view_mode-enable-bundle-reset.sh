#!/usr/bin/env bash
# Execution RESET: ensure paragraph type pvm_task exists WITH a saved default form display but
# WITHOUT the Paragraph View Mode feature (no paragraph_view_mode FieldConfig, no form-display
# component), so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  if (!ParagraphsType::load("pvm_task")) {
    ParagraphsType::create(["id" => "pvm_task", "label" => "PVM Task"])->save();
  }
  $storage = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  if (!$storage->load("paragraph.pvm_task.default")) {
    $storage->create([
      "targetEntityType" => "paragraph", "bundle" => "pvm_task", "mode" => "default", "status" => TRUE,
    ])->save();
  }
  // Force the feature OFF.
  \Drupal::service("paragraph_view_mode.storage_manager")->deleteField("pvm_task");
  $fd = $storage->load("paragraph.pvm_task.default");
  if ($fd && $fd->getComponent("paragraph_view_mode")) {
    $fd->removeComponent("paragraph_view_mode")->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: paragraph type pvm_task exists, Paragraph View Mode feature OFF"
