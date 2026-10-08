#!/usr/bin/env bash
# Introspection SETUP: create a Menu Export (mm_export_type) config entity mm_mig_probe that
# exports the main menu to the codebase in YAML, so an inspecting agent can read its
# destination + format back from config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_migration\Entity\ExportType;
  if (!ExportType::load("mm_mig_probe")) {
    ExportType::create([
      "name" => "mm_mig_probe",
      "label" => "MM Probe Export",
      "destination" => "codebase",
      "destination_config" => [
        "format" => "yaml",
        "menus" => ["main"],
        "export_path" => "../config/menu_migration/mm_mig_probe",
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mm_export_type mm_mig_probe (destination=codebase, format=yaml)"
