#!/usr/bin/env bash
# Introspection SETUP: create a fixed_block_content config entity fbc_prot with protected = TRUE
# so an inspecting agent can read that its custom block is protected (non-reusable). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("fixed_block_content");
  if (!$s->load("fbc_prot")) {
    $s->create([
      "id" => "fbc_prot", "title" => "Protected Promo Block",
      "block_content_bundle" => "basic", "auto_export" => 0, "protected" => TRUE,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: fixed_block_content fbc_prot (protected=TRUE) created"
