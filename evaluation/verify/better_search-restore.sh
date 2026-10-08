#!/usr/bin/env bash
# Shared restore: put better_search.settings back to its shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("better_search.settings")
    ->set("placeholder_text", "search")
    ->set("theme", 0)
    ->set("size", 20)
    ->set("searchpage_enable", TRUE)
    ->set("searchpage_submit_not_visible", TRUE)
    ->set("input_name", "keys")
    ->set("block_form_id", "search_block_form")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "restore: better_search.settings reset to shipped defaults"
