#!/usr/bin/env bash
# Introspection SETUP: make sure the namespaced content type lbat_demo exists with Layout
# Builder per-item overrides enabled, and put the layout_builder_at_copy widget on its default
# form display with appearance 'checked_hidden'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("lbat_demo")) {
    try { NodeType::create(["type" => "lbat_demo", "name" => "LBAT Demo"])->save(); }
    catch (\Throwable $e) { /* other modules may fail their node-type hooks; the type is saved */ }
  }
' >/dev/null 2>&1
drush php:eval '
  $vs = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $vs->load("node.lbat_demo.default") ?: $vs->create(["targetEntityType" => "node", "bundle" => "lbat_demo", "mode" => "default", "status" => TRUE]);
  $vd->setThirdPartySetting("layout_builder", "enabled", TRUE)
     ->setThirdPartySetting("layout_builder", "allow_custom", TRUE)
     ->save();
  $fs = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $fs->load("node.lbat_demo.default") ?: $fs->create(["targetEntityType" => "node", "bundle" => "lbat_demo", "mode" => "default", "status" => TRUE]);
  $fd->setComponent("layout_builder__layout", [
    "type" => "layout_builder_at_copy", "region" => "content", "weight" => 90,
    "settings" => ["appearance" => "checked_hidden"], "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
echo "setup: node.lbat_demo has layout_builder overrides + layout_builder_at_copy widget (appearance=checked_hidden)"
