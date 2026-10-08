#!/usr/bin/env bash
# Introspection SETUP: create the Pool that a migration would produce so an agent can read
# its backend_url. Config-only; no backend contact.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cms_content_sync\Entity\Pool;
  if (!Pool::load("ccs_ach_pool")) {
    Pool::create(["id"=>"ccs_ach_pool","label"=>"CCS ACH Pool","backend_url"=>"https://acquia-migrated.content-sync.example"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pool ccs_ach_pool backend_url=https://acquia-migrated.content-sync.example"
