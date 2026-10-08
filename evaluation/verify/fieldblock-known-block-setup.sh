#!/usr/bin/env bash
# Introspection SETUP: place a Field as Block instance (fieldblock_eval_body) that renders the
# node body with the trimmed-summary formatter and does NOT take its title from the field label,
# so the agent must read the live block config to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("fieldblock_eval_body")) { $b->delete(); }
  Block::create([
    "id" => "fieldblock_eval_body", "theme" => "olivero", "region" => "sidebar", "weight" => 10,
    "plugin" => "fieldblock:node",
    "settings" => [
      "id" => "fieldblock:node", "label" => "Body in the sidebar", "label_display" => "visible",
      "provider" => "fieldblock", "label_from_field" => FALSE,
      "field_name" => "body", "formatter_id" => "text_summary_or_trimmed",
      "formatter_settings" => ["trim_length" => 300],
    ],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block fieldblock_eval_body = fieldblock:node, field body, formatter text_summary_or_trimmed"
exit 0
