#!/usr/bin/env bash
# Introspection SETUP: create an HTMX Block config entity (htmx_med) that wraps the core
# "Powered by Drupal" block, so an agent can read back which core block plugin it stores.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\htmx\Entity\HtmxBlock;
  if (!HtmxBlock::load("htmx_med")) {
    HtmxBlock::create([
      "id" => "htmx_med", "label" => "HTMX Med Promo",
      "plugin" => "system_powered_by_block",
      "settings" => ["id" => "system_powered_by_block", "label" => "Powered by Drupal", "provider" => "system", "label_display" => "visible"],
      "visibility" => [],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: htmx.htmx_block.htmx_med plugin=system_powered_by_block"
