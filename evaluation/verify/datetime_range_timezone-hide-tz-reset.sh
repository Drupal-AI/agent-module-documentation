#!/usr/bin/env bash
# Execution RESET: create field_drt_disp with the default daterange_timezone formatter and force
# display_timezone = TRUE, so verify (which wants it hidden) FAILs until the agent turns it off.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_drt_disp")) {
    FieldStorageConfig::create([
      "field_name" => "field_drt_disp", "entity_type" => "node",
      "type" => "daterange_timezone", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_drt_disp")) {
    FieldConfig::create([
      "field_name" => "field_drt_disp", "entity_type" => "node",
      "bundle" => "article", "label" => "Display Range",
    ])->save();
  }
  \Drupal::service("entity_display.repository")->getViewDisplay("node","article")
    ->setComponent("field_drt_disp", [
      "type" => "daterange_timezone",
      "settings" => ["separator" => "-", "format_type" => "medium", "display_timezone" => TRUE],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_drt_disp daterange_timezone formatter display_timezone=TRUE"
