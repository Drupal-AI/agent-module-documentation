#!/usr/bin/env bash
# Introspection SETUP: create a known cms_content_sync Pool so an agent can read its
# backend_url/site_id back from live config. Config-only; does NOT contact any backend.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cms_content_sync\Entity\Pool;
  if (!Pool::load("ccs_known_pool")) {
    Pool::create([
      "id" => "ccs_known_pool", "label" => "CCS Known Pool",
      "backend_url" => "https://known.content-sync.example",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pool ccs_known_pool backend_url=https://known.content-sync.example"
