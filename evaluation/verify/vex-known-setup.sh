#!/usr/bin/env bash
# Introspection SETUP: create a view vex_known whose contextual filters use the views_extras
# 'cookie' and 'session' default-argument plugins, so an agent can read the keys back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($e = View::load("vex_known")) { $e->delete(); }
  View::create([
    "id" => "vex_known", "label" => "VEX Known", "base_table" => "node_field_data",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "arguments" => [
            "nid" => [
              "id" => "nid", "table" => "node_field_data", "field" => "nid", "plugin_id" => "node_nid",
              "default_action" => "default", "default_argument_type" => "cookie",
              "default_argument_options" => ["cookie_key" => "vex_ckey", "fallback_value" => "vex_cfallback"],
            ],
            "uid" => [
              "id" => "uid", "table" => "node_field_data", "field" => "uid", "plugin_id" => "node_uid",
              "default_action" => "default", "default_argument_type" => "session",
              "default_argument_options" => ["session_key" => "vex_skey", "fallback_value" => "vex_sfallback", "cache_time" => "0"],
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vex_known (nid->cookie vex_ckey, uid->session vex_skey)"
