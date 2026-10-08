#!/usr/bin/env bash
# Introspection SETUP: create a custom block content type btt_known so an inspecting agent can find
# it and derive the per-type template block_type_templates enables. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block_content\Entity\BlockContentType;
  if (!BlockContentType::load("btt_known")) {
    BlockContentType::create(["id"=>"btt_known","label"=>"BTT Known"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block content type btt_known created"
