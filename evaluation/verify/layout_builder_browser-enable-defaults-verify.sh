#!/usr/bin/env bash
# Execution VERIFY for "enable the browser on default layouts and use a modal".
# PASS when layout_builder_browser.settings has BOTH "defaults" and "overrides" in
# enabled_section_storages AND use_modal is truthy. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("layout_builder_browser.settings");
  $storages = array_values((array) ($c->get("enabled_section_storages") ?? []));
  $modal = $c->get("use_modal");
  $ok = in_array("defaults", $storages, TRUE) && in_array("overrides", $storages, TRUE) && !empty($modal);
  print ($ok ? "PASS" : "FAIL") . " storages=[" . implode(",", $storages) . "]"
    . " use_modal=" . var_export($modal, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
