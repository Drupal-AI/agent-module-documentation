#!/usr/bin/env bash
# Introspection CLEANUP: restore layout_builder_browser.settings to the module's shipped
# baseline (config/install): enabled_section_storages=[overrides], modal off, nothing
# auto-added. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_browser.settings")
    ->set("enabled_section_storages", ["overrides"])
    ->set("use_modal", FALSE)
    ->set("auto_added_reusable_block_content_bundles", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: layout_builder_browser.settings restored to baseline (overrides / no modal)"
