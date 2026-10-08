#!/usr/bin/env bash
# Execution RESET (ui_styles_layout_builder): enable Layout Builder on node.page default with a
# single plain section that has NO ui_styles settings, so verify FAILS until the agent adds a
# section style. Idempotent.
set -uo pipefail
cd /var/www/html
drush en layout_builder ui_styles_layout_builder -y >/dev/null 2>&1
drush php:eval '
  use Drupal\layout_builder\Section;
  $storage = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $display = $storage->load("node.page.default");
  if (!$display) {
    $display = $storage->create(["targetEntityType" => "node", "bundle" => "page", "mode" => "default", "status" => TRUE]);
  }
  $display->enableLayoutBuilder();
  $display->removeAllSections();
  $display->appendSection(new Section("layout_onecol"));
  $display->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.page.default LB enabled with a plain section (no ui_styles)"
