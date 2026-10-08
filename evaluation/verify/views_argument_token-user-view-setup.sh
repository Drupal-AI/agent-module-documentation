#!/usr/bin/env bash
# Introspection SETUP: create a view "vat_user" whose contextual filter (uid) uses the
# views_argument_token "token" default-argument plugin with token string [current-user:uid],
# so an inspecting agent can read the configured token back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("vat_user")) {
    View::create([
      "id" => "vat_user",
      "label" => "VAT user",
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
                "default_argument_type" => "token",
                "default_argument_options" => [
                  "argument" => "[current-user:uid]",
                  "process" => 0,
                  "and_or" => "+",
                  "all_option" => 1,
                  "debug" => 0,
                ],
              ],
            ],
          ],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vat_user contextual filter uid default_argument_type=token argument=[current-user:uid]"
