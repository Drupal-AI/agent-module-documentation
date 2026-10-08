#!/usr/bin/env bash
# Introspection SETUP: create a text format "iva_eval" with the Advanced Insert View filter
# (insert_view_adv) enabled, so an agent can discover which format uses it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("filter_format");
  if (!$s->load("iva_eval")) {
    $s->create([
      "format" => "iva_eval",
      "name" => "IVA Eval Format",
      "weight" => 20,
      "filters" => [
        "insert_view_adv" => [
          "id" => "insert_view_adv", "provider" => "insert_view_adv",
          "status" => TRUE, "weight" => 10,
          "settings" => ["allowed_views" => [], "render_as_empty" => 0, "hide_argument_input" => 1],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: text format iva_eval has insert_view_adv filter enabled"
