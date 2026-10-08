#!/usr/bin/env bash
# setup: View cv_roles_known on base_table config_user_role
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("cv_roles_known")) { $v->delete(); }
  View::create([
    "id" => "cv_roles_known", "label" => "cv_roles_known", "base_table" => "config_user_role", "base_field" => "id",
    "display" => ["default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Master", "position" => 0,
      "display_options" => ["query" => ["type" => "views_config_entity_query"],
        "fields" => ["id" => ["id" => "id", "table" => "config_user_role", "field" => "id", "plugin_id" => "standard"]]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: View cv_roles_known on base_table config_user_role"
