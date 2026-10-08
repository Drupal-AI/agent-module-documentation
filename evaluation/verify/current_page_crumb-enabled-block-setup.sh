#!/usr/bin/env bash
# Introspection SETUP: place two namespaced Breadcrumb blocks in Olivero - cpc_m_on (enabled)
# and cpc_m_off (disabled) - so an inspecting agent must read live block config to say which
# one is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (["cpc_m_on","cpc_m_off"] as $id) { if ($b = Block::load($id)) { $b->delete(); } }
  Block::create([
    "id" => "cpc_m_on", "theme" => "olivero", "region" => "sidebar",
    "weight" => 0, "plugin" => "system_breadcrumb_block", "status" => TRUE,
    "settings" => ["id" => "system_breadcrumb_block", "label" => "Breadcrumbs",
      "label_display" => "0", "provider" => "system"],
    "visibility" => [],
  ])->save();
  Block::create([
    "id" => "cpc_m_off", "theme" => "olivero", "region" => "content",
    "weight" => 0, "plugin" => "system_breadcrumb_block", "status" => FALSE,
    "settings" => ["id" => "system_breadcrumb_block", "label" => "Breadcrumbs",
      "label_display" => "0", "provider" => "system"],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cpc_m_on (status=true) and cpc_m_off (status=false) placed in olivero"
