#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore the three shipped mobile presets so verify FAILS on empty
# state (no 'Tablet ME' preset). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c = \Drupal::configFactory()->getEditable("mercury_editor.settings");
  $c->set("dialog_tray_width", 400)->set("edit_screen_theme", "")
    ->set("mobile_presets", [
      ["name" => "iPhone 12 Pro", "width" => 390, "height" => 844],
      ["name" => "iPhone XR", "width" => 414, "height" => 896],
      ["name" => "Pixel 5", "width" => 393, "height" => 851],
    ])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mercury_editor.settings mobile_presets restored to shipped defaults"
