#!/usr/bin/env bash
# Introspection SETUP: enable Layout Builder with per-item overrides on the namespaced bundle
# lbat_demo (and nothing else), so the agent must inspect entity_view_display config to find
# which bundle allows per-item layouts. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("lbat_demo")) {
    try { NodeType::create(["type" => "lbat_demo", "name" => "LBAT Demo"])->save(); }
    catch (\Throwable $e) { }
  }
' >/dev/null 2>&1
drush php:eval '
  $vs = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $vs->load("node.lbat_demo.default") ?: $vs->create(["targetEntityType" => "node", "bundle" => "lbat_demo", "mode" => "default", "status" => TRUE]);
  $vd->setThirdPartySetting("layout_builder", "enabled", TRUE)
     ->setThirdPartySetting("layout_builder", "allow_custom", TRUE)
     ->save();
' >/dev/null 2>&1
echo "setup: node.lbat_demo.default view display has layout_builder enabled + allow_custom"
