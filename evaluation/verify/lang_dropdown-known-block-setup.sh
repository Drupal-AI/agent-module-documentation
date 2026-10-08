#!/usr/bin/env bash
# Introspection SETUP: place a KNOWN lang_dropdown block `eval_ld_known` so an inspecting
# agent can read its settings back via drush. Known facts baked in here:
#   plugin  = language_dropdown_block:language_interface
#   widget  = 2   (Chosen output type)
#   display = 2   (Language Code label format)
#   width   = 250
#   showall = TRUE
# Idempotent: deletes any prior eval_ld_known first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $id = "eval_ld_known";
  $storage = \Drupal::entityTypeManager()->getStorage("block");
  if ($b = $storage->load($id)) { $b->delete(); }
  $theme = \Drupal::config("system.theme")->get("default");
  $storage->create([
    "id" => $id,
    "theme" => $theme,
    "region" => "sidebar",
    "plugin" => "language_dropdown_block:language_interface",
    "settings" => [
      "id" => "language_dropdown_block:language_interface",
      "label" => "Eval Known Language Dropdown",
      "label_display" => "visible",
      "widget" => 2,
      "display" => 2,
      "width" => 250,
      "showall" => TRUE,
      "hide_only_one" => FALSE,
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block eval_ld_known placed (plugin language_dropdown_block:language_interface, widget=2 Chosen, display=2 langcode, width=250, showall=on)"
