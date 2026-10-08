#!/usr/bin/env bash
# Introspection SETUP: place a Simple Search Form block (id ssf_medium2) with submit label 'Go SSF'.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("ssf_medium2")) { $b->delete(); }
  Block::create([
    "id" => "ssf_medium2", "theme" => "olivero", "region" => "content",
    "plugin" => "simple_search_form_block",
    "settings" => [
      "id" => "simple_search_form_block", "label" => "SSF Medium 2", "label_display" => "0",
      "action_path" => "/ssf-two", "get_parameter" => "q2",
      "input_type" => "search", "submit_display" => TRUE, "submit_label" => "Go SSF",
      "input_keep_value" => TRUE,
    ],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block ssf_medium2 (submit_label='Go SSF')"
