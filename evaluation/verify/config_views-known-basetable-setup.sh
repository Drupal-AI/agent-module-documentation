#!/usr/bin/env bash
# setup: View cv_known on base_table config_image_style
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("cv_known")) { $v->delete(); }
  View::create([
    "id" => "cv_known", "label" => "cv_known", "base_table" => "config_image_style", "base_field" => "name",
    "display" => ["default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Master", "position" => 0,
      "display_options" => ["query" => ["type" => "views_config_entity_query"],
        "fields" => ["name" => ["id" => "name", "table" => "config_image_style", "field" => "name", "plugin_id" => "standard"]]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: View cv_known on base_table config_image_style"
