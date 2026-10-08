#!/usr/bin/env bash
# Introspection SETUP: put layout_builder_browser.settings into a known NON-default state —
# browser enabled for the "defaults" section storage only, modal ON, and the "basic" block
# content bundle auto-added. The agent must read the live config to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_browser.settings")
    ->set("enabled_section_storages", ["defaults"])
    ->set("use_modal", TRUE)
    ->set("auto_added_reusable_block_content_bundles", ["basic"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: enabled_section_storages=[defaults] use_modal=TRUE auto_added=[basic]"
