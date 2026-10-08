#!/usr/bin/env bash
# Introspection SETUP: create a custom block content type btt_vm so an inspecting agent can derive
# its view-mode-specific template suggestion. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block_content\Entity\BlockContentType;
  if (!BlockContentType::load("btt_vm")) {
    BlockContentType::create(["id"=>"btt_vm","label"=>"BTT VM"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block content type btt_vm created"
