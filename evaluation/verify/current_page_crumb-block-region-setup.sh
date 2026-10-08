#!/usr/bin/env bash
# Introspection SETUP: place a namespaced Breadcrumb block (id cpc_m_breadcrumb,
# system_breadcrumb_block) in the Olivero theme's "content" region so an inspecting agent can
# read back which region current_page_crumb's crumbs would render through. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("cpc_m_breadcrumb")) { $b->delete(); }
  Block::create([
    "id" => "cpc_m_breadcrumb", "theme" => "olivero", "region" => "content",
    "weight" => 0, "plugin" => "system_breadcrumb_block", "status" => TRUE,
    "settings" => ["id" => "system_breadcrumb_block", "label" => "Breadcrumbs",
      "label_display" => "0", "provider" => "system"],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block cpc_m_breadcrumb (system_breadcrumb_block) placed in olivero region=content"
