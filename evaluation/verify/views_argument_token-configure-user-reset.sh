#!/usr/bin/env bash
# Execution RESET: (re)create view "vat_task" with a uid contextual filter whose default is a
# FIXED value (NOT the token plugin), so verify FAILS until the agent switches it to
# views_argument_token with token [current-user:uid]. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vat_task")) { $v->delete(); }
  View::create([
    "id" => "vat_task",
    "label" => "VAT task",
    "base_table" => "users_field_data",
    "base_field" => "uid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "arguments" => [
            "uid" => [
              "id" => "uid",
              "table" => "users_field_data",
              "field" => "uid",
              "plugin_id" => "numeric",
              "entity_type" => "user",
              "entity_field" => "uid",
              "default_action" => "default",
              "default_argument_type" => "fixed",
              "default_argument_options" => ["argument" => "1"],
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vat_task uid argument default_argument_type=fixed (token not yet used)"
