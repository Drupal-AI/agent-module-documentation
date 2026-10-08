#!/usr/bin/env bash
# Execution RESET: ensure an enabled 'fmc_task' form mode + form display exist for node.article,
# and empty form_mode_control.settings defaults so verify FAILS until the agent sets it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager();
  // Ensure the form mode exists.
  $fmStorage = $etm->getStorage("entity_form_mode");
  if (!$fmStorage->load("node.fmc_task")) {
    $fmStorage->create(["id" => "node.fmc_task", "label" => "FMC Task", "targetEntityType" => "node"])->save();
  }
  // Ensure an enabled form display for node.article.fmc_task exists.
  $fdStorage = $etm->getStorage("entity_form_display");
  if (!$fdStorage->load("node.article.fmc_task")) {
    $fdStorage->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "fmc_task", "status" => TRUE,
    ])->save();
  }
  else {
    $fd = $fdStorage->load("node.article.fmc_task");
    if (!$fd->status()) { $fd->setStatus(TRUE)->save(); }
  }
  // Empty defaults.
  \Drupal::configFactory()->getEditable("form_mode_control.settings")->set("defaults", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.fmc_task enabled form display present; defaults emptied"
