#!/usr/bin/env bash
# Execution RESET: restore shipped defaults with an EMPTY predefined class_list, so verify FAILS
# until the agent adds the required class. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $all = ["id" => TRUE, "class_list" => TRUE, "class" => TRUE, "style" => TRUE, "data" => TRUE];
  \Drupal::configFactory()->getEditable("layout_custom_section_classes.settings")
    ->set("allowed_section_attributes", $all)
    ->set("allowed_section_region_attributes", $all)
    ->set("class_list", [])
    ->set("relax_css_validation", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: layout_custom_section_classes.settings class_list = [] (empty)"
