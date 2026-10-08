#!/usr/bin/env bash
# Introspection SETUP (ui_styles_layout_builder): enable Layout Builder on node.page default
# display with one section that carries a UI Styles section-level extra class
# (ui-styles-eval-lb), so an agent can read it back. Idempotent (rebuilds the section).
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
  $section = new Section("layout_onecol");
  $section->setThirdPartySetting("ui_styles", "extra", "ui-styles-eval-lb");
  $display->appendSection($section);
  $display->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.page.default LB enabled; section 0 ui_styles extra=ui-styles-eval-lb"
