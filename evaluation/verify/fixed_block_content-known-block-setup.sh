#!/usr/bin/env bash
# Introspection SETUP: create a fixed_block_content config entity fbc_known (title "Known Footer
# Block", target custom block bundle "basic") so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("fixed_block_content");
  if (!$s->load("fbc_known")) {
    $s->create([
      "id" => "fbc_known", "title" => "Known Footer Block",
      "block_content_bundle" => "basic", "auto_export" => 0, "protected" => FALSE,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: fixed_block_content fbc_known (bundle basic) created"
