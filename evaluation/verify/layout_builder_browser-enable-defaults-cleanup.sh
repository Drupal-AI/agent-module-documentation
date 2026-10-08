#!/usr/bin/env bash
# Execution CLEANUP: force layout_builder_browser.settings back to the shipped baseline —
# enabled_section_storages=[overrides], use_modal=FALSE — leaving the site at baseline after the agent
# enables the browser for the default-layout screen and switches on the modal.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_browser.settings")
    ->set("enabled_section_storages", ["overrides"])
    ->set("use_modal", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: enabled_section_storages=[overrides] use_modal=FALSE"
