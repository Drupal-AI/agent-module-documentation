#!/usr/bin/env bash
# Introspection SETUP: place a Search API form block 'sab_known' with a known action_url and
# input_name so an agent can read the live block config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("sab_known")) { $b->delete(); }
  Block::create([
    "id" => "sab_known", "plugin" => "search_api_form_block",
    "region" => "content", "theme" => $theme,
    "settings" => [
      "id" => "search_api_form_block", "label" => "SAB Known", "label_display" => "0",
      "action_url" => "/sab-search", "action_method" => "get",
      "input_name" => "custom_keys", "input_placeholder" => "", "submit_value" => "",
      "input_label" => "", "input_label_visibility" => "invisible", "pass_get_params" => FALSE,
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block.block.sab_known placed (action_url=/sab-search, input_name=custom_keys)"
