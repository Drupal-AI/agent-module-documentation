#!/usr/bin/env bash
# Introspection SETUP: place a Simple Search Form block (id ssf_medium) with known settings so an
# agent can read back its get_parameter/action_path from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("ssf_medium")) { $b->delete(); }
  Block::create([
    "id" => "ssf_medium", "theme" => "olivero", "region" => "content",
    "plugin" => "simple_search_form_block",
    "settings" => [
      "id" => "simple_search_form_block", "label" => "SSF Medium", "label_display" => "0",
      "action_path" => "/ssf-search", "get_parameter" => "q_ssf",
      "input_type" => "search", "submit_display" => TRUE, "submit_label" => "Find",
    ],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block ssf_medium (get_parameter=q_ssf, action_path=/ssf-search)"
